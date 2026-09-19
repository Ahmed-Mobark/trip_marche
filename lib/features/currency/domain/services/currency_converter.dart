class CurrencyConverter {
  const CurrencyConverter._();

  /// Normalizes [amount] through the rates returned by `/currencies`.
  static double? toEgp({
    required double amount,
    required double selectedRate,
    required double egpRate,
  }) {
    if (!amount.isFinite ||
        !selectedRate.isFinite ||
        !egpRate.isFinite ||
        selectedRate <= 0 ||
        egpRate <= 0) {
      return null;
    }
    return amount * selectedRate / egpRate;
  }
}
