//
//  SearchViewModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import Foundation
import Combine

final class SearchViewModel: CombineViewModelType {
    
    @Published
    var input: Input = Input()
    
    @Published
    var output: Output = Output()
    
    var cancellabel: Set<AnyCancellable> = []
    
    init(){
        transform()
    }
}

extension SearchViewModel {
    
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never> ()
        var deleteButtonTap = PassthroughSubject<Int, Never> ()
        var allDeleteButtonTap = PassthroughSubject<Void, Never> ()
        var searchButtonTap = PassthroughSubject<Void,Never> ()
        var currentText = ""
    }
    
    struct Output {
        var searchList: [String] = []
        var searchText: String = ""
    }
}

extension SearchViewModel {
    func transform() {
        
        input.viewOnAppear
            .sink { [weak self] _ in
                self?.output.searchList = UserDefaultManager.searchHistory
            }
            .store(in: &cancellabel)
        
        input.deleteButtonTap
            .sink {[weak self] indexAt in
                self?.output.searchList.remove(at: indexAt)
                UserDefaultManager.searchHistory.remove(at: indexAt)
            }
            .store(in: &cancellabel)
        
        input.allDeleteButtonTap
            .sink {[weak self] _ in
                self?.output.searchList.removeAll()
                UserDefaultManager.searchHistory.removeAll()
            }
            .store(in: &cancellabel)
        
        input.searchButtonTap
            .map({ [weak self] _ in
                return self?.input.currentText ?? ""
            })
            .sink {[weak self] text in
                UserDefaultManager.searchHistory.insert(text, at: 0)
                self?.output.searchList = UserDefaultManager.searchHistory
                self?.output.searchText = text
            }
            .store(in: &cancellabel)
        
        
    }
}