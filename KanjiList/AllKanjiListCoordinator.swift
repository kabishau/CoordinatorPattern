import UIKit

class AllKanjiListCoordinator: Coordinator {

    private let presenter: UINavigationController
    private let allKanjiList: [Kanji]
    private var kanjiListViewController: KanjiListViewController?
    private let kanjiStorage: KanjiStorage
    
    private var kanjiDetailCoordinator: KanjiDetailCoordinator?
    
    
    init(presenter: UINavigationController, kanjiStorage: KanjiStorage) {
        self.presenter = presenter
        self.kanjiStorage = kanjiStorage
        allKanjiList = kanjiStorage.allKanji()
    }
    
    func start() {
        let kanjiListViewController = KanjiListViewController(nibName: nil, bundle: nil)
        kanjiListViewController.title = "Kanji List"
        kanjiListViewController.kanjiList = allKanjiList
        presenter.pushViewController(kanjiListViewController, animated: true)
        
        self.kanjiListViewController = kanjiListViewController
        kanjiListViewController.delegate = self
        
    }
}


extension AllKanjiListCoordinator: KanjiListViewControllerDelegate {
    func kanjiListViewControllerDidSelectKanji(_ selectedKanji: Kanji) {
        
        let kanjiDetailCoordinator = KanjiDetailCoordinator(presenter: presenter, kanji: selectedKanji, kanjiStorage: kanjiStorage)
        kanjiDetailCoordinator.start()
        self.kanjiDetailCoordinator = kanjiDetailCoordinator
    }
}
