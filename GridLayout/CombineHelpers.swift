//
//  CombineHelpers.swift
//  GridLayout
//
//  Created by Damian Kolasiński on 23/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import UIKit
import Combine

extension AnyCancellable {
    public func disposed(by disposeBag: DisposeBag) {
        disposeBag.add(cancellable: self)
    }
}

public class DisposeBag {
    private var cancellables = [AnyCancellable]()
    
    fileprivate func add(cancellable: AnyCancellable) {
        cancellables.append(cancellable)
    }
}

public final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Void {
    private var subscriber: SubscriberType?

    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }

    public func request(_ demand: Subscribers.Demand) {}
    public func cancel() { subscriber = nil }

    @objc private func eventHandler() {
        _ = subscriber?.receive(())
    }
}

public struct UIControlPublisher<Control: UIControl>: Publisher {
    public typealias Output = Void
    public typealias Failure = Never

    private weak var control: Control?
    private let controlEvents: UIControl.Event

    init(control: Control, events: UIControl.Event) {
        self.control = control
        self.controlEvents = events
    }
    
    public func receive<S: Subscriber>(subscriber: S) where S.Failure == Never, S.Input == Void {
        guard let control = control else { return }
        let subscription = UIControlSubscription(
            subscriber: subscriber,
            control: control,
            event: controlEvents
        )
        subscriber.receive(subscription: subscription)
    }
}

public protocol CombineCompatible {}
extension UIControl: CombineCompatible {}
extension CombineCompatible where Self: UIControl {
    public func publisher(for events: UIControl.Event) -> UIControlPublisher<Self> {
        return UIControlPublisher(control: self, events: events)
    }
}
