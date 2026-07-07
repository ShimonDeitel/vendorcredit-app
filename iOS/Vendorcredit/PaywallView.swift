import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var purchases: PurchaseManager

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
                VStack(spacing: 20) {
                    Image(systemName: "star.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(Theme.accent)
                    Text("Vendorcredit Pro")
                        .font(Theme.titleFont)
                        .foregroundStyle(Theme.textPrimary)
                    Text("Payment reminders and multi-person balance summary")
                        .font(Theme.bodyFont)
                        .foregroundStyle(Theme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                    Spacer()
                    Button {
                        Task {
                            await purchases.purchase()
                            if purchases.isPro { dismiss() }
                        }
                    } label: {
                        Text(purchases.product?.displayPrice ?? "$1.99")
                            .font(Theme.headlineFont)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.accent)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius))
                    }
                    .accessibilityIdentifier("purchaseButton")
                    .padding(.horizontal, 24)

                    Button("Not Now") {
                        dismiss()
                    }
                    .accessibilityIdentifier("paywallDismissButton")
                    .foregroundStyle(Theme.textSecondary)
                    .padding(.bottom, 24)
                }
                .padding(.top, 60)
            }
        }
    }
}
