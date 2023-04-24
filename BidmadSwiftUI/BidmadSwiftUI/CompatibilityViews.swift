//
//  CompatibilityViews.swift
//  BidmadSwiftUI
//
//  Created by Seungsub Oh on 2023/04/06.
//

import SwiftUI

struct CompatibilityNavigationStack<CustomView: View>: View {
    let root: () -> CustomView
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(root: root)
        } else {
            NavigationView(content: root)
                .navigationViewStyle(.stack)
        }
    }
}

struct CompatibilityDestinationModifier<Destination: View>: ViewModifier {
    @Binding var isPresented: Bool
    var destination: () -> Destination
    
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .navigationDestination(isPresented: $isPresented, destination: destination)
        } else {
            content
                .background(
                    NavigationLink(
                        destination: destination(),
                        isActive: $isPresented,
                        label: { EmptyView() }
                    )
                )
        }
    }
}

extension View {
    func compatibilityNavigationDestination<Destination: View>(isPresented: Binding<Bool>, destination: @escaping () -> Destination) -> some View {
        modifier(CompatibilityDestinationModifier(isPresented: isPresented, destination: destination))
    }
}

struct CompatibilityColorGradience: ViewModifier {
    let colors: [UIColor]
    let startPoint: UnitPoint = .bottom
    let endPoint: UnitPoint = .top
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .background(LinearGradient(colors: colors.map({ Color(uiColor: $0) }), startPoint: startPoint, endPoint: endPoint))
        } else {
            content
                .background(LinearGradient(colors: colors.map({ Color($0) }), startPoint: startPoint, endPoint: endPoint))
        }
    }
}
