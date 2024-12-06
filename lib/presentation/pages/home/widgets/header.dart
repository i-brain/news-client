import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_client/core/extension.dart';
import 'package:news_client/data/auth/login/cubit/login_cubit.dart';
import 'package:news_client/data/get_news/cubit/get_news_cubit.dart';
import 'package:news_client/presentation/dialogs/error.dart';
import 'package:news_client/presentation/pages/home/widgets/login_dialog.dart';
import 'package:news_client/presentation/pages/home/widgets/register_dialog.dart';
import '../../../../responsive.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xffb8191f),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: Responsive.horizontalPadding(context),
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  context.read<GetNewsCubit>().get();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Mews",
                        style: context.style.titleLarge
                            ?.copyWith(fontSize: 32, color: Colors.white)),
                    const SizedBox(width: 10),
                    const Icon(Icons.flutter_dash, size: 32)
                  ],
                ),
              ),
            ),
            const Spacer(),
            StreamBuilder(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) {
                final user = snapshot.data;
                if (user != null) {
                  return BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LogoutSuccess) {
                        context.read<GetNewsCubit>().get();
                      }
                      if (state is LogoutFailure) {
                        showErrorDialog(context, state.message);
                      }
                    },
                    child: TextButton(
                      onPressed: () {
                        context.read<LoginCubit>().logout();
                      },
                      child: const Text('Logout'),
                    ),
                  );
                }
                return Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        LoginDialog.show(context);
                      },
                      child: const Text('Login'),
                    ),
                    TextButton(
                      onPressed: () {
                        RegisterDialog.show(context);
                      },
                      child: const Text('Register'),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
