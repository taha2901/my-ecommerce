import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({Key? key}) : super(key: key);

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data for users
  final List<Map<String, dynamic>> users = [
    {
      'id': '1',
      'name': 'أحمد محمد',
      'email': 'ahmed@example.com',
      'phone': '+966501234567',
      'type': 'customer',
      'status': 'active',
      'joinDate': '2023-12-15',
      'orderCount': 12,
      'totalSpent': 1200.50,
      'avatar': 'assets/images/avatar1.jpg',
    },
    {
      'id': '2',
      'name': 'فاطمة علي',
      'email': 'fatima@example.com',
      'phone': '+966509876543',
      'type': 'customer',
      'status': 'active',
      'joinDate': '2023-11-20',
      'orderCount': 8,
      'totalSpent': 800.00,
      'avatar': 'assets/images/avatar2.jpg',
    },
    {
      'id': '3',
      'name': 'محمد التاجر',
      'email': 'vendor@example.com',
      'phone': '+966512345678',
      'type': 'vendor',
      'status': 'active',
      'joinDate': '2023-10-10',
      'orderCount': 0,
      'totalSpent': 0,
      'avatar': 'assets/images/avatar3.jpg',
    },
    {
      'id': '4',
      'name': 'سارة أحمد',
      'email': 'sara@example.com',
      'phone': '+966598765432',
      'type': 'customer',
      'status': 'suspended',
      'joinDate': '2023-09-05',
      'orderCount': 3,
      'totalSpent': 150.75,
      'avatar': 'assets/images/avatar4.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: AppBar(
        title: const Text('إدارة المستخدمين'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showAddUserDialog,
            icon: const Icon(Icons.person_add),
            tooltip: 'إضافة مستخدم جديد',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'الكل'),
            Tab(text: 'العملاء'),
            Tab(text: 'التجار'),
            Tab(text: 'محظور'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Statistics Cards
          Container(
            padding: EdgeInsets.all(16.w),
            color: AppColors.primary.withOpacity(0.05),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: 'إجمالي المستخدمين',
                    value: '${users.length}',
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    title: 'العملاء',
                    value: '${_getUsersByType('customer').length}',
                    icon: Icons.person,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    title: 'التجار',
                    value: '${_getUsersByType('vendor').length}',
                    icon: Icons.store,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    title: 'محظور',
                    value: '${_getUsersByStatus('suspended').length}',
                    icon: Icons.block,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'البحث بالاسم أو البريد الإلكتروني...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: IconButton(
                    onPressed: _showFilterDialog,
                    icon: const Icon(Icons.tune, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Users List with Tabs
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUsersList(users),
                _buildUsersList(_getUsersByType('customer')),
                _buildUsersList(_getUsersByType('vendor')),
                _buildUsersList(_getUsersByStatus('suspended')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.r),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUsersList(List<Map<String, dynamic>> userList) {
    if (userList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 80.r,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 16.h),
            Text(
              'لا يوجد مستخدمون',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: userList.length,
      itemBuilder: (context, index) {
        final user = userList[index];
        return _buildUserCard(user, index);
      },
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(16.w),
            leading: CircleAvatar(
              radius: 25.r,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                user['name'][0],
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    user['name'],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getUserTypeColor(user['type']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    _getUserTypeText(user['type']),
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: _getUserTypeColor(user['type']),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Text(
                  user['email'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  user['phone'],
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: user['status'] == 'active' 
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        user['status'] == 'active' ? 'نشط' : 'محظور',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: user['status'] == 'active' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'انضم: ${user['joinDate']}',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'view',
                  child: ListTile(
                    leading: Icon(Icons.visibility),
                    title: Text('عرض التفاصيل'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('تعديل'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                PopupMenuItem(
                  value: 'toggle_status',
                  child: ListTile(
                    leading: Icon(
                      user['status'] == 'active' ? Icons.block : Icons.check_circle,
                      color: user['status'] == 'active' ? Colors.red : Colors.green,
                    ),
                    title: Text(
                      user['status'] == 'active' ? 'حظر' : 'إلغاء الحظر',
                      style: TextStyle(
                        color: user['status'] == 'active' ? Colors.red : Colors.green,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text('حذف', style: TextStyle(color: Colors.red)),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 'view':
                    _showUserDetails(user);
                    break;
                  case 'edit':
                    _showEditUserDialog(user);
                    break;
                  case 'toggle_status':
                    _toggleUserStatus(index);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(index);
                    break;
                }
              },
            ),
          ),
          if (user['type'] == 'customer')
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildCustomerStat(
                      'الطلبات',
                      '${user['orderCount']}',
                      Icons.shopping_bag,
                      Colors.blue,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30.h,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: _buildCustomerStat(
                      'إجمالي المشتريات',
                      '\$${user['totalSpent']}',
                      Icons.attach_money,
                      Colors.green,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomerStat(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 16.r),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getUsersByType(String type) {
    return users.where((user) => user['type'] == type).toList();
  }

  List<Map<String, dynamic>> _getUsersByStatus(String status) {
    return users.where((user) => user['status'] == status).toList();
  }

  Color _getUserTypeColor(String type) {
    switch (type) {
      case 'customer':
        return Colors.green;
      case 'vendor':
        return Colors.orange;
      case 'admin':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getUserTypeText(String type) {
    switch (type) {
      case 'customer':
        return 'عميل';
      case 'vendor':
        return 'تاجر';
      case 'admin':
        return 'أدمن';
      default:
        return 'غير محدد';
    }
  }

  void _showUserDetails(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تفاصيل المستخدم: ${user['name']}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('الاسم:', user['name']),
              _buildDetailRow('البريد الإلكتروني:', user['email']),
              _buildDetailRow('رقم الهاتف:', user['phone']),
              _buildDetailRow('النوع:', _getUserTypeText(user['type'])),
              _buildDetailRow('الحالة:', user['status'] == 'active' ? 'نشط' : 'محظور'),
              _buildDetailRow('تاريخ الانضمام:', user['joinDate']),
              if (user['type'] == 'customer') ...[
                _buildDetailRow('عدد الطلبات:', '${user['orderCount']}'),
                _buildDetailRow('إجمالي المشتريات:', '\$${user['totalSpent']}'),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditUserDialog(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تعديل المستخدم: ${user['name']}'),
        content: const Text('هنا سيتم إضافة نموذج لتعديل بيانات المستخدم'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تعديل بيانات المستخدم بنجاح')),
              );
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _toggleUserStatus(int index) {
    setState(() {
      users[index]['status'] = users[index]['status'] == 'active' ? 'suspended' : 'active';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم ${users[index]['status'] == 'active' ? 'إلغاء حظر' : 'حظر'} المستخدم',
        ),
      ),
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف المستخدم'),
        content: Text('هل أنت متأكد من حذف "${users[index]['name']}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                users.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم حذف المستخدم بنجاح')),
              );
            },
            child: const Text('حذف', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة مستخدم جديد'),
        content: const Text('هنا سيتم إضافة نموذج لإضافة مستخدم جديد'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إضافة المستخدم بنجاح')),
              );
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تصفية المستخدمين'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('نوع المستخدم'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              title: const Text('الحالة'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              title: const Text('تاريخ الانضمام'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تطبيق'),
          ),
        ],
      ),
    );
  }
}