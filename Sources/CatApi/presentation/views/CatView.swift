import Foundation

class CatView{
    static let instance:CatView = CatView()
    let catPresenter:CatPresenter = CatPresenter.instance

    func start(){

        catPresenter.getAllBreeds(onCompletion:{
            cats in print(cats)
        })

        var data = readLine()
    }
}