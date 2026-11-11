class FaqItem {
  final String question;
  final String answer;

  const FaqItem({
    required this.question,
    required this.answer,
  });

  static const defaultFaq = FaqItem(
    question: 'When do review coins arrive?',
    answer:
        'After publication and eligibility checks. Each eligible review is rewarded once — never for likes.',
  );
}

class SupportRecentOrder {
  final String orderId;
  final String restaurant;

  const SupportRecentOrder({
    this.orderId = '#THK84291',
    this.restaurant = 'Shadab Biryani',
  });

  String get summary => '$orderId · $restaurant';
}

