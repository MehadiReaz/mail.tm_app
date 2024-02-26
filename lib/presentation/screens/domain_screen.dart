import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/domain_model.dart';
import '../blocs/domain/domain_cubit.dart';
import 'login_screen.dart';

class DomainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DomainCubit(),
      child: BlocBuilder<DomainCubit, DomainState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Domain Screen'),
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, DomainState state) {
    if (state is DomainInitial) {
      // Initial state or loading state
      context
          .read<DomainCubit>()
          .getDomains(); // Trigger the request to get domains
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is DomainsLoaded) {
      // Display the list of domains
      return ListView.builder(
        itemCount: state.domains.length,
        itemBuilder: (context, index) {
          return _buildDomainItem(context, state.domains[index]);
        },
      );
    } else if (state is DomainError) {
      // Error state
      return Center(
        child: Text(
          'Error: ${state.error}',
          style: TextStyle(color: Colors.red),
        ),
      );
    } else {
      return Container(); // Handle other states if needed
    }
  }

  Widget _buildDomainItem(BuildContext context, DomainModel domain) {
    return ListTile(
      title: Text(domain.domain),
      onTap: () {
        // Navigate to the login screen with the selected domain
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(
              selectedDomain: domain.domain,
              domain: domain.domain,
            ),
          ),
        );
      },
    );
  }
}
