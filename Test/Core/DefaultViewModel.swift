//
//  DefaultViewModel.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//



import UIKit

open class DefaultViewModel {
    
    public var isLoading: Dynamic<Bool?> = Dynamic<Bool?>(nil)
    public var appError: Dynamic<Error?> = Dynamic(.none)
    public var taskCounter: Dynamic<Int> = Dynamic<Int>(0)
    public let taskStarting: Dynamic<Bool> = Dynamic<Bool>(false)
    public let taskEnding: Dynamic<Bool> = Dynamic<Bool>(false)
    public let tableReload: Dynamic<Bool> = Dynamic<Bool>(false)
    public let state: Dynamic<ViewModelState> = Dynamic<ViewModelState>(.initializing)
    
    private var _taskCounter: Int = 0
        
    public init() {
       
        taskCounter.bind { count in
            self._taskCounter = count
            self.isLoading.value = count > 0
        }

        taskStarting.bind { _ in
            self._taskCounter += 1
            self.taskCounter.value = self._taskCounter
        }
        
        taskEnding.bind { _ in
            if self._taskCounter > 0 {
                self._taskCounter -= 1
                self.taskCounter.value = self._taskCounter
            }
        }
            
        appError.bind { _ in
            self.taskEnding.value = true
        }
       
        isLoading.bindAndFire { isLoading in
            self.state.value = (isLoading == true) ? ViewModelState.loading : ViewModelState.loadComplete
        }
        
        self.state.value = ViewModelState.ready
    }
    
}
