part of 'proposal_cubit.dart';

sealed class ProposalState {
  const ProposalState();
}

/// الحالة الابتدائية
final class ProposalInitial extends ProposalState {
  const ProposalInitial();
}

/// عند تغيير أي قيمة داخل الفورم
final class ProposalFormChanged extends ProposalState {
  const ProposalFormChanged();
}

/// أثناء إرسال الـ Proposal
final class ProposalLoading extends ProposalState {
  const ProposalLoading();
}

/// عند نجاح الإرسال
final class ProposalSuccess extends ProposalState {
  const ProposalSuccess();
}

/// عند حدوث خطأ
final class ProposalFailure extends ProposalState {
  final String message;

  const ProposalFailure(this.message);
}