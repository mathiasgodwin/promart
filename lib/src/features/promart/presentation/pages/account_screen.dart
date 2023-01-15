import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promart/src/features/promart/presentation/bloc/bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final userName = state.user.email;
        final userEmail = state.user.email;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                userName!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
              SizedBox(height: 10.w),
              Text(userEmail!)
            ],
          ),
        );
      },
    );
  }
}
