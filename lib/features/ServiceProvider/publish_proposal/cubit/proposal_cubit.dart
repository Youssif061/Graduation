import 'package:expertisemarket/features/ServiceProvider/publish_proposal/model/proposal_model.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_proposal/repository/proposal_repository.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_proposal/repository/proposal_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'proposal_state.dart';

class ProposalCubit extends Cubit<ProposalState> {
  ProposalCubit()
      : repository = ProposalRepositoryImpl(),
        super(const ProposalInitial());

  final ProposalRepository repository;

  Future<void> sendProposal({
    required String requestId,
    required String price,
    required String duration,
    required String message,
  }) async {
    try {
      emit(const ProposalLoading());

      final proposal = ProposalModel(
        id: '',
        requestId: requestId,
        providerId: '',
        price: double.parse(price),
        duration: duration,
        message: message,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      await repository.sendProposal(
        proposal,
      );

      emit(const ProposalSuccess());
    } catch (e) {
      emit(
        ProposalFailure(
          e.toString(),
        ),
      );
    }
  }
}