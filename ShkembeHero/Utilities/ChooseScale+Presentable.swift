//
//  ChooseScale+Presentable.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/3/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Flow
import Presentation

extension ChooseScale: Presentable {
    func materialize() -> (UIView, Disposable) {
        let content = UIView()
        content.backgroundColor = .background
        
        let image = UIImageView()
        
        let title = UILabel(text: "", style: .secondaryAction)
        title.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = Float(options.count - 1)
        slider.value = Float(chosenPosition())
        
        [image, title, slider].forEach {
            content.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let verticalSpacing: CGFloat = 5
        let margin: CGFloat = 16
        
        activate(
            image.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            image.topAnchor.constraint(greaterThanOrEqualTo: content.topAnchor),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            image.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -verticalSpacing),
            slider.heightAnchor.constraint(equalToConstant: 44),
            slider.leftAnchor.constraint(equalTo: content.leftAnchor, constant: margin),
            slider.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -margin),
            title.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            title.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: verticalSpacing),
            title.bottomAnchor.constraint(equalTo: content.bottomAnchor)
        )
        
        let bag = DisposeBag()
        
        let sliderUpdate = slider.signal(for: UIControlEvents.valueChanged)
            .map { slider.value }.readable(capturing: slider.value)
        
        let state = State(presentable: self, sliderUpdate: sliderUpdate)
        bag += state.updatedCurrent.bindTo(self.current)
        
        bag += current.atOnce().onValue { value in
            let animationDuration = 0.25
            let animationOptions: UIViewAnimationOptions = [.transitionCrossDissolve, .beginFromCurrentState]
            
            UIView.transition(with: image,
                              duration: animationDuration,
                              options: animationOptions,
                              animations: { image.image = value.image },
                              completion: nil)
            
            UIView.transition(with: title,
                              duration: animationDuration,
                              options: animationOptions,
                              animations: { title.text = value.title },
                              completion: nil)
        }
        
        return (content, bag)
    }
}

private extension ChooseScale {
    struct State {
        let presentable: ChooseScale
        let sliderUpdate: ReadSignal<Float>
        
        var updatedCurrent: Signal<Option<Scale>> {
            return sliderUpdate.map { Int(roundf($0)) }
                .filter { $0 != self.presentable.chosenPosition() }
                .map { self.presentable.options[$0] }.atValue { print($0) }
        }
    }
    
    func chosenPosition() -> Int {
        guard let index = options.index(where: { $0.value == current.value.value }) else {
            return 0
        }
        return index
    }
}
