import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_proposal/model/proposal_model.dart';
import 'proposal_repository.dart';

class ProposalRepositoryImpl
    implements ProposalRepository {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth auth =
      FirebaseAuth.instance;

  @override
  Future<void> sendProposal(
    ProposalModel proposal,
  ) async {
    final doc =
        firestore.collection("proposals").doc();

    final newProposal = proposal.copyWith(
      id: doc.id,
      providerId: auth.currentUser!.uid,
    );

    await doc.set(
      newProposal.toMap(),
    );
  }
}