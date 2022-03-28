import Foundation

class CatView{
    static let instance:CatView = CatView()
    let votedCat:CatViewVoted = CatViewVoted()
    let catPresenter:CatPresenter = CatPresenter.instance

    func start(){
        catPresenter.loadBreeds()
        viewMainMenu()
    }

    func viewMainMenu(){
        print("Welcome to TheApiCat\n1.Initial letters of Breeds\n2.Breeds Library\n3.The Cat Breed Battle\n4.Exit")

        switch readLine()! {
        case "1":
                votedCat.showInitialLettersOfTheBreeds()
        case "2":
                showBreedsLibrary()
        case "3":
                votedCat.votesView()
        default:
           print("bye")
           cleanConsole()
        }
    }

    func cleanConsole(){
        print("\u{1B}[1;1H", "\u{1B}[2J")
    }

    func showBreedsLibrary(){
        let listCats = catPresenter.getbreeds()
        for cat  in listCats {
            print("\(cat.name) -> origin: \(cat.origin)" )  
        }
    }
 
    //
}