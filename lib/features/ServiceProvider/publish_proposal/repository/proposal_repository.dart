import 'package:expertisemarket/features/ServiceProvider/publish_proposal/model/proposal_model.dart';

abstract class ProposalRepository {
  Future<void> sendProposal(
    ProposalModel proposal,
  );
}