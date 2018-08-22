import UIKit

class KanjiDetailCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var kanjiDetailViewController: KanjiDetailViewController?
    private var wordKanjiViewController: KanjiListViewController?
    private let kanjiStorage: KanjiStorage
    private let kanji: Kanji
    
    init(presenter: UINavigationController, kanji: Kanji, kanjiStorage: KanjiStorage) {
        self.presenter = presenter
        self.kanji = kanji
        self.kanjiStorage = kanjiStorage
    }
    
    func start() {
        let kanjiDetailViewController = KanjiDetailViewController(nibName: nil, bundle: nil)
        kanjiDetailViewController.title = "Kanji Details"
        kanjiDetailViewController.selectedKanji = kanji
        
        presenter.pushViewController(kanjiDetailViewController, animated: true)
        
        self.kanjiDetailViewController = kanjiDetailViewController
        kanjiDetailViewController.delegate = self
    }
    
}

extension KanjiDetailCoordinator: KanjiDetailViewControllerDelegate {
    func kanjiDetailViewControllerDidSelectWord(_ word: String) {
        let wordKanjiListViewController = KanjiListViewController(nibName: nil, bundle: nil)
        wordKanjiListViewController.cellAccessoryType = .none
        let kanjiForWord = kanjiStorage.kanjiForWord(word)
        wordKanjiListViewController.kanjiList = kanjiForWord
        wordKanjiListViewController.title = word
        
        presenter.pushViewController(wordKanjiListViewController, animated: true)
    }
}
