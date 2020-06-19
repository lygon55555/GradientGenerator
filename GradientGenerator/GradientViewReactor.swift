//
//  GradientViewReactor.swift
//  GradientGenerator
//
//  Created by Yonghyun on 2020/06/17.
//  Copyright © 2020 Yonghyun. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class GradientViewReactor: Reactor {
    enum Action {
        case color(Int)
        case redColor(Int, Int)
        case blueColor(Int, Int)
        case greenColor(Int, Int)
        case alphaValue(Int, Int)
    }
    
    enum Mutation {
        case colorSelected(Int)
        case redColor(Int)
        case greenColor(Int)
        case blueColor(Int)
        case alphaValue(Int)
        case hexValue(Int)
        case colorImage(Int)
        case gradient
    }
    
    struct State {
        var colors = [UserDefaults.standard.array(forKey: UserDefaultKey.color0),                                   UserDefaults.standard.array(forKey: UserDefaultKey.color1),                                   UserDefaults.standard.array(forKey: UserDefaultKey.color2)]
        
        var color0 = UserDefaults.standard.array(forKey: UserDefaultKey.color0) as? [Int] ?? [Int]()
        var color1 = UserDefaults.standard.array(forKey: UserDefaultKey.color1) as? [Int] ?? [Int]()
        var color2 = UserDefaults.standard.array(forKey: UserDefaultKey.color2) as? [Int] ?? [Int]()
        
        var redValue: Int?
        var greenValue: Int?
        var blueValue: Int?
        var alphaValue: Int?
        
        var selectedColor: String?
        
        var colorImageBackgroundColors: [CGColor]?
    }
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
    switch action {
        case let .color(num):
            return Observable.concat([
                Observable.just(Mutation.colorSelected(num)),
                Observable.just(Mutation.redColor(num)),
                Observable.just(Mutation.greenColor(num)),
                Observable.just(Mutation.blueColor(num)),
                Observable.just(Mutation.alphaValue(num)),
                Observable.just(Mutation.hexValue(num))
            ])

        case let .redColor(num, value):
            return Observable.concat([
                Observable.just(Mutation.redColor(num)),
                Observable.just(Mutation.colorImage(num)),
                Observable.just(Mutation.hexValue(num)),
                Observable.just(Mutation.gradient)
            ])

        case let .greenColor(num, value):
            return Observable.concat([
                Observable.just(Mutation.greenColor(num)),
                Observable.just(Mutation.colorImage(num)),
                Observable.just(Mutation.hexValue(num)),
                Observable.just(Mutation.gradient)
            ])

        case let .blueColor(num, value):
            return Observable.concat([
                Observable.just(Mutation.blueColor(num)),
                Observable.just(Mutation.colorImage(num)),
                Observable.just(Mutation.hexValue(num)),
                Observable.just(Mutation.gradient)
            ])

        case let .alphaValue(num, value):
            return Observable.concat([
                Observable.just(Mutation.alphaValue(num)),
                Observable.just(Mutation.colorImage(num)),
                Observable.just(Mutation.hexValue(num)),
                Observable.just(Mutation.gradient)
            ])
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .colorSelected(num):
            state.colorImageBackgroundColors = state.colorImageBackgroundColors.map{ _ in UIColor.white.cgColor } as? [CGColor]
            state.colorImageBackgroundColors?[num] = UIColor.black.cgColor
            state.redValue = state.colors[num]?[0] as? Int
            state.greenValue = state.colors[num]?[1] as? Int
            state.blueValue = state.colors[num]?[2] as? Int
            state.alphaValue = state.colors[num]?[3] as? Int
        case let .redColor(num):
        case let .greenColor(num):
        case let .blueColor(num):
        case let .alphaValue(num):
        case let .hexValue(num):
        case let .color(num):
        case let .gradient:
        }
        
        return state
    }
}
