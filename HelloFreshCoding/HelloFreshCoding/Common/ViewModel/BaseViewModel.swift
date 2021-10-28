//
//  RecipeViewModel.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

public class BaseViewModel {
    
    public weak var delegate : BaseViewModelDelegate?
    private var ready:Bool = false
    private var loading:Bool = false
    
    public func load() {
        self.loading = true
    }
    
    public func load(with delegate: BaseViewModelDelegate) {
        self.delegate = delegate
        self.load()
    }
    
    @discardableResult
    public func isReady(_ shouldNotifyDelegate: Bool = true)->Bool {
        if ready && shouldNotifyDelegate {
            self.makeReady()
        }
        return ready
    }

    public func isLoading() -> Bool {
        return loading
    }
    
    public func makeReady() {
        self.ready = true
        self.loading = false
        self.delegate?.onViewModelReady(self)
    }
    
    public func reset() {
        self.ready = false
        self.loading = false
        self.delegate?.onViewModelNeedsUpdate(self)
    }
    
    public func throwError(with error: Error) {
        //In some cases we are receving errors from background threads.
        //We need to make sure we use main thread since we are going to interact with UI
        Run.onMainThread {
            self.loading = false
            self.delegate?.onViewModelError(self, error: error)
        }
    }
}

public protocol BaseViewModelDelegate : AnyObject {
    func onViewModelReady(_ viewModel:BaseViewModel)
    func onViewModelError(_ viewModel:BaseViewModel, error: Error)
    func onViewModelNeedsUpdate(_ viewModel: BaseViewModel)
}
