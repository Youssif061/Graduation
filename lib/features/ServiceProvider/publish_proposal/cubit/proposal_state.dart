part of 'proposal_cubit.dart';

sealed class ProposalState {
  const ProposalState();
}

//==========================================
// Initial
//==========================================

final class ProposalInitial
    extends ProposalState {
  const ProposalInitial();
}

//==========================================
// Form Changed
//==========================================

final class ProposalFormChanged
    extends ProposalState {
  const ProposalFormChanged();
}

//==========================================
// Loading
//==========================================

final class ProposalLoading
    extends ProposalState {
  const ProposalLoading();
}

//==========================================
// Success
//==========================================

final class ProposalSuccess
    extends ProposalState {
  const ProposalSuccess();
}

//==========================================
// Failure
//==========================================

final class ProposalFailure
    extends ProposalState {
  const ProposalFailure(
    this.message,
  );

  final String message;
}