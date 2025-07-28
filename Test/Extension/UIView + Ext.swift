//
//  UIView + Ext.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit
import SwiftUI

public extension UIView {
    var safeTopAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.topAnchor
    }

    var safeLeftAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.leftAnchor
    }

    var safeRightAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.rightAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.bottomAnchor
    }

    @discardableResult
    func left(toView view: UIView, constant value: CGFloat = 0) -> NSLayoutConstraint {
        let result = leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: value)
        result.isActive = true
        return result
    }

    func leftNotSafe(toView view: UIView, constant value: CGFloat = 0) {
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: value).isActive = true
    }

    func relativeLeft(toView view: UIView, constant value: CGFloat) {
        leftAnchor.constraint(equalTo: view.safeRightAnchor, constant: value).isActive = true
    }

    @discardableResult
    func right(toView view: UIView, constant value: CGFloat = 0) -> NSLayoutConstraint {
        let result = rightAnchor.constraint(equalTo: view.safeRightAnchor, constant: -value)
        result.isActive = true
        return result
    }

    func right(toView view: UIView, greaterThanOrEqualToConstant value: CGFloat) {
        rightAnchor.constraint(greaterThanOrEqualTo: view.safeRightAnchor, constant: -value).isActive = true
    }

    func left(toView view: UIView, greaterThanOrEqualToConstant value: CGFloat) {
        leftAnchor.constraint(greaterThanOrEqualTo: view.safeLeftAnchor, constant: value).isActive = true
    }

    func rightNotSafe(toView view: UIView, constant value: CGFloat = 0) {
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -value).isActive = true
    }

    func relativeRight(toView view: UIView, constant value: CGFloat) {
        rightAnchor.constraint(equalTo: view.safeLeftAnchor, constant: value).isActive = true
    }

    @discardableResult
    func top(toView view: UIView, constant value: CGFloat = 0) -> NSLayoutConstraint {
        let result = topAnchor.constraint(equalTo: view.safeTopAnchor, constant: value)
        result.isActive = true
        return result
    }

    @discardableResult
    func top(toView view: UIView, greaterThanOrEqualToConstant value: CGFloat) -> NSLayoutConstraint {
        let result = topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: value)
        result.isActive = true
        return result
    }

    @discardableResult
    func bottom(toView view: UIView, constant value: CGFloat = 0) -> NSLayoutConstraint {
        let result = bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -value)
        result.isActive = true
        return result
    }

    @discardableResult
    func bottom(toView view: UIView, greaterThanOrEqualToConstant value: CGFloat) -> NSLayoutConstraint {
        let result = bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -value)
        result.isActive = true
        return result
    }

    @discardableResult
    func topNotSafe(toView view: UIView, constant value: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = topAnchor.constraint(equalTo: view.topAnchor, constant: value)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func bottomNotSafe(toView view: UIView, constant value: CGFloat = 0) -> NSLayoutConstraint {
        let con = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -value)
        con.isActive = true
        return con
    }

    @discardableResult
    func relativeBottom(toView view: UIView, constant value: CGFloat = 0) -> NSLayoutConstraint {
        let con = bottomAnchor.constraint(equalTo: view.safeTopAnchor, constant: -value)
        con.isActive = true
        return con
    }

    @discardableResult
    func relativeBottom(toView view: UIView, greaterThanOrEqualTo value: CGFloat) -> NSLayoutConstraint {
        let con = bottomAnchor.constraint(greaterThanOrEqualTo: view.safeTopAnchor, constant: -value)
        con.isActive = true
        return con
    }

    func relativeTop(toView view: UIView, constant value: CGFloat = 0) {
        topAnchor.constraint(equalTo: view.safeBottomAnchor, constant: value).isActive = true
    }

    func relativeTop(toView view: UIView, greaterThanOrEqualTo value: CGFloat) {
        topAnchor.constraint(greaterThanOrEqualTo: view.safeBottomAnchor, constant: value).isActive = true
    }

    @discardableResult
    func height(equalTo dimension: NSLayoutDimension) -> NSLayoutConstraint {
        let con = heightAnchor.constraint(equalTo: dimension)
        con.isActive = true
        return con
    }

    @discardableResult
    func height(equalTo dimension: NSLayoutDimension, constant value: CGFloat) -> NSLayoutConstraint {
        let con = heightAnchor.constraint(equalTo: dimension, constant: value)
        con.isActive = true
        return con
    }

    func height(equalTo dimension: NSLayoutDimension, multiplier: CGFloat = 1) {
        heightAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
    }

    @discardableResult
    func height(equalTo constant: CGFloat) -> NSLayoutConstraint {
        let con = heightAnchor.constraint(equalToConstant: constant)
        con.isActive = true
        return con
    }

    func width(equalTo dimension: NSLayoutDimension) {
        widthAnchor.constraint(equalTo: dimension).isActive = true
    }

    func width(equalTo dimension: NSLayoutDimension, constant value: CGFloat) {
        widthAnchor.constraint(equalTo: dimension, constant: value).isActive = true
    }

    func width(equalTo dimension: NSLayoutDimension, multiplier: CGFloat = 1) {
        widthAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
    }

    func width(equalTo constant: CGFloat) {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func height(greaterThanOrEqualToConstant constant: CGFloat) {
        heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }

    func height(lessThanOrEqualToConstant constant: CGFloat) {
        heightAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }

    func width(lessThanOrEqualTo dimension: NSLayoutDimension, multiplier: CGFloat = 1) {
        widthAnchor.constraint(lessThanOrEqualTo: dimension, multiplier: multiplier).isActive = true
    }

    func width(lessThanOrEqualTo constant: CGFloat) {
        widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }

    func width(greaterThanOrEqualToConstant constant: CGFloat) {
        widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }

    func centerVertically(to view: UIView, constant: CGFloat = 0) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }

    func centerHorizontally(to view: UIView, constant: CGFloat = 0) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }

    func fillSides(to view: UIView, safeArea: Bool = true) {
        translatesAutoresizingMaskIntoConstraints = false
        if safeArea {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.topAnchor),
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }

    func center(to view: UIView) {
        centerVertically(to: view)
        centerHorizontally(to: view)
    }

    func setSize(_ point: CGFloat) {
        height(equalTo: point)
        width(equalTo: point)
    }

    func setSize(height: CGFloat, width: CGFloat) {
        self.height(equalTo: height)
        self.width(equalTo: width)
    }

    func horizontalConstraint(from view: UIView, _ point: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        left(toView: view, constant: point)
        right(toView: view, constant: point)
    }

    func vertical(from view: UIView, _ point: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        top(toView: view, constant: point)
        bottom(toView: view, constant: point)
    }

    @discardableResult
    func embed(into superview: UIView, margins: UIEdgeInsets = .zero, style: EmbedStyle = .fill) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        constraint(to: superview, margins: margins, style: style)
        return self
    }

    @discardableResult
    func embed(
        into superview: UIView,
        constraintTo view: UIView,
        margins: UIEdgeInsets = .zero,
        style: EmbedStyle = .fill
    ) -> Self {
        superview.addSubview(self)
        constraint(to: view, margins: margins, style: style)
        return self
    }

    @discardableResult
    func embed(
        into superview: UIView,
        constraintTo guide: UILayoutGuide,
        margins: UIEdgeInsets = .zero,
        style: EmbedStyle = .fill
    ) -> Self {
        superview.addSubview(self)
        constraint(to: guide, margins: margins, style: style)
        return self
    }
}



extension UIView {
    public enum EmbedStyle {
        /// Растягивает вью по всей ширине и высоте
        case fill
        /// Растягивает по ширине и приклеивает к верху вью
        case topFill
        /// Растягивает по ширине и приклеивает к низу вью
        case bottomFill
        /// Устанавливает вью в верхний правый угол
        case topRight
        /// Центрирует по горизонтали и приклеивает к низу вью
        case bottomCenter
        /// Растягивает по высоте и приклеивает к правой части вью
        case rightFill
        /// Растягивает по высоте и приклеивает к левой части вью
        case leftFill
        /// Центрирует на вью
        case center
        /// Растягивает по вертикали и центрирует по горизонтали
        case centerX
        /// Растягивает по горизонтали и центрирует по вертикали
        case centerY
        /// Приклеивает и центрирует к левому краю вью
        case left
        /// Приклеивает и центрирует к правому краю вью
        case right
    }

    func constraint(to view: UIView, margins: UIEdgeInsets = .zero, style: EmbedStyle = .fill) {
        constraint(
            topAnchor: view.topAnchor,
            leftAnchor: view.leftAnchor,
            rightAnchor: view.rightAnchor,
            bottomAnchor: view.bottomAnchor,
            centerXAnchor: view.centerXAnchor,
            centerYAnchor: view.centerYAnchor,
            margins: margins,
            style: style
        )
    }

    func constraint(to guide: UILayoutGuide, margins: UIEdgeInsets = .zero, style: EmbedStyle = .fill) {
        constraint(
            topAnchor: guide.topAnchor,
            leftAnchor: guide.leftAnchor,
            rightAnchor: guide.rightAnchor,
            bottomAnchor: guide.bottomAnchor,
            centerXAnchor: guide.centerXAnchor,
            centerYAnchor: guide.centerYAnchor,
            margins: margins,
            style: style
        )
    }

    // swiftlint:disable function_body_length
    func constraint(
        topAnchor: NSLayoutYAxisAnchor,
        leftAnchor: NSLayoutXAxisAnchor,
        rightAnchor: NSLayoutXAxisAnchor,
        bottomAnchor: NSLayoutYAxisAnchor,
        centerXAnchor: NSLayoutXAxisAnchor,
        centerYAnchor: NSLayoutYAxisAnchor,
        margins: UIEdgeInsets = .zero,
        style: EmbedStyle
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []

        switch style {
        case .left, .fill, .topFill, .bottomFill, .leftFill, .centerY:
            constraints.append(
                self.leftAnchor.constraint(equalTo: leftAnchor, constant: margins.left)
            )
        case .center, .right, .bottomCenter, .centerX, .topRight:
            constraints.append(
                self.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: margins.left)
            )
        case .rightFill:
            break
        }

        switch style {
        case .right, .fill, .topFill, .bottomFill, .rightFill, .topRight, .centerY:
            constraints.append(
                self.rightAnchor.constraint(equalTo: rightAnchor, constant: -margins.right)
            )
        case .center, .left, .bottomCenter, .leftFill, .centerX:
            constraints.append(
                self.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -margins.right)
            )
        }

        switch style {
        case .fill, .bottomFill, .rightFill, .bottomCenter, .leftFill, .centerX:
            constraints.append(
                self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margins.bottom)
            )
        case .right, .left, .center, .centerY, .topRight:
            constraints.append(
                self.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -margins.bottom)
            )
        case .topFill:
            break
        }

        switch style {
        case .fill, .topFill, .rightFill, .topRight, .leftFill, .centerX:
            constraints.append(
                self.topAnchor.constraint(equalTo: topAnchor, constant: margins.top)
            )
        case .right, .left, .center, .centerY:
            constraints.append(
                self.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: margins.top)
            )
        case .bottomFill, .bottomCenter:
            break
        }

        switch style {
        case .center, .left, .right, .centerY:
            constraints.append(
                self.centerYAnchor.constraint(equalTo: centerYAnchor)
            )
        case .fill, .topFill, .bottomFill, .rightFill, .bottomCenter, .topRight, .leftFill, .centerX:
            break
        }

        switch style {
        case .center, .bottomCenter, .centerX:
            constraints.append(
                self.centerXAnchor.constraint(equalTo: centerXAnchor)
            )
        case .fill, .topFill, .bottomFill, .left, .right, .rightFill, .topRight, .leftFill, .centerY:
            break
        }

        NSLayoutConstraint.activate(constraints)
    }
    // swiftlint:enable function_body_length
}

extension UIView {
    public static func springAnimate(animations: @escaping () -> Void, completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.5,
            delay: .zero,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: {
                animations()
            },
            completion: { _ in
                completion?()
            }
        )
    }
}

public extension UIView {
    var asSwiftUI: some View {
        ViewRepresented(self)
    }

    var radius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

private struct ViewRepresented<T: UIView>: UIViewRepresentable {
    private(set) var view: T

    init(_ view: T) {
        self.view = view
    }

    func makeUIView(context: Context) -> some UIView {
        view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
