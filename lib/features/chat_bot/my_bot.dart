import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:iconsax/iconsax.dart';

class EcommerceChatBotScreen extends StatefulWidget {
  const EcommerceChatBotScreen({super.key});

  @override
  State<EcommerceChatBotScreen> createState() => _EcommerceChatBotScreenState();
}

class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  Message({required this.text, required this.isUser, required this.timestamp});
}

class _EcommerceChatBotScreenState extends State<EcommerceChatBotScreen> {
  late GenerativeModel _model;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _initializeAIModel();
    _addMessage(
      'مرحباً! أنا مساعدك الذكري في متجرنا. كيف يمكنني مساعدتك اليوم؟\n'
      'يمكنك أن تسأل عن:\n'
      '- حالة الطلب\n'
      '- المنتجات المتاحة\n'
      '- العروض والتخفيضات\n'
      '- سياسة الإرجاع والاستبدال\n'
      '- أي استفسار آخر',
      false,
    );
  }

  Future<void> _initializeAIModel() async {
    const apiKey = 'AIzaSyBXAbOtFoxQ1yDfOuINGdG4uKh5EekrBJI'; // استبدل بمفتاحك
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        maxOutputTokens: 1000,
        temperature: 0.7,
        topP: 0.8,
        topK: 10,
      ),
    );
  }

  void _addMessage(String text, bool isUser) {
    if (!mounted) return;
    setState(() {
      _messages.add(
        Message(text: text, isUser: isUser, timestamp: DateTime.now()),
      );
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _controller.clear();
    _addMessage(text, true);

    setState(() => _isTyping = true);

    try {
      final response = await _getBotResponse(text);
      if (mounted) {
        setState(() => _isTyping = false);
        _addMessage(response, false);
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (mounted) {
        setState(() => _isTyping = false);
        _addMessage('عذراً، حدث خطأ. يرجى المحاولة مرة أخرى.', false);
      }
    }
  }

  Future<String> _getBotResponse(String userMessage) async {
    try {
      final prompt = """
أنت مساعد ذكي لمتجر إلكتروني يسمى "متجرنا". مهمتك:
1. الإجابة على استفسارات العملاء حول المنتجات
2. مساعدة العملاء في تتبع الطلبات
3. تقديم معلومات عن العروض والتخفيضات
4. شرح سياسات الإرجاع والاستبدال
5. تقديم توصيات للمنتجات بناءً على تفضيلات العميل
6. الإجابة على الأسئلة العامة عن المتجر

معلومات المتجر:
- سياسة الإرجاع: 14 يومًا
- الشحن المجاني للطلبات فوق 200 ريال
- أوقات العمل: من 8 صباحًا إلى 10 مساءً

سؤال العميل: $userMessage

الرجاء تقديم إجابة مفيدة ودقيقة مع الحفاظ على لغة مهنية وودية.
""";

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      return response.text ??
          'عذراً، لم أتمكن من فهم سؤالك. يرجى إعادة صياغته.';
    } catch (e) {
      debugPrint('API Error: $e');
      throw Exception('خطأ في الاتصال بالخدمة');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Iconsax.arrow_left, color: Colors.white),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kPrimaryColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.shopping_cart,
                color: AppColors.kPrimaryColor,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مساعد المتجر',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'نساعدك في تجربة تسوق أفضل',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: AppColors.kPrimaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              backgroundColor: AppColors.kPrimaryColor,
              child: Icon(Icons.shopping_cart, size: 20, color: Colors.white),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser ? AppColors.kPrimaryColor : Colors.white,
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomLeft:
                      message.isUser ? Radius.circular(20) : Radius.circular(4),
                  bottomRight:
                      message.isUser ? Radius.circular(4) : Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.grey[600]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.kPrimaryColor,
            child: Icon(Icons.shopping_cart, size: 20, color: Colors.white),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20).copyWith(
                bottomLeft: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(),
                SizedBox(width: 4),
                _buildTypingDot(),
                SizedBox(width: 4),
                _buildTypingDot(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك هنا...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: AppColors.kPrimaryColor,
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: _isTyping ? null : _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}