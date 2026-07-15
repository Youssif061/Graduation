import 'package:expertisemarket/features/ServiceProvider/publish_proposal/model/proposal_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'proposal_state.dart';

class ProposalCubit extends Cubit<ProposalState> {
  ProposalCubit() : super(const ProposalInitial());

  /// إرسال عرض جديد
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

      /// ======================================
      /// Firebase Firestore
      ///
      /// await FirebaseFirestore.instance
      ///     .collection('proposals')
      ///     .add(proposal.toMap());
      /// ======================================

      await Future.delayed(
        const Duration(seconds: 1),
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