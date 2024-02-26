import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qtec_solution_task/presentation/widgets/custom_height.dart';

import '../../data/models/domain_model.dart';
import '../blocs/domain/domain_cubit.dart';
import 'login_screen.dart';

class DomainScreen extends StatelessWidget {
  const DomainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DomainCubit(),
      child: BlocBuilder<DomainCubit, DomainState>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, DomainState state) {
    if (state is DomainInitial) {
      context.read<DomainCubit>().getDomains();
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is DomainsLoaded) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomHeight(height: 60),
            const Text(
              'Availavle Domains',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 26),
            ),
            const CustomHeight(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: state.domains.length,
              itemBuilder: (context, index) {
                return _buildDomainItem(context, state.domains[index]);
              },
            ),
          ],
        ),
      );
    } else if (state is DomainError) {
      // Error state
      return Center(
        child: Text(
          'Error: ${state.error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    } else {
      return Container(); // Handle other states if needed
    }
  }

  Widget _buildDomainItem(BuildContext context, DomainModel domain) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: const Card(
            child: Icon(
              FontAwesomeIcons.earth,
            ),
          ),
          title: Text(
            domain.domain,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: .5,
            ),
          ),
          trailing: const Icon(Icons.arrow_circle_right_outlined),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(
                  selectedDomain: domain.domain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
