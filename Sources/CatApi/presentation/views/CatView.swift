import Foundation

class CatView{
    static let instance:CatView = CatView()
    let catPresenter:CatPresenter = CatPresenter.instance

    func start(){
        catPresenter.loadBreeds()
        viewMainMenu()
    }

    func viewMainMenu(){
        print("Welcome to TheApiCat\n1.Initial letters of Breeds\n2.Breeds Library\n3.The Cat Breed Battle\n4.Exit")

        switch readLine()! {
        case "1":
                showInitialLettersOfTheBreeds()
        case "2":
                showBreedsLibrary()
        case "3":
                votesView()
        default:
           print("bye..bye =D")
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

    func showInitialLettersOfTheBreeds(){
        
        let letters = catPresenter.getinitialLetterBreeds()
        for letter  in letters {
            print(letter)
        }

        searchBreedInitialLetter()

        goBackSystemMainMenuView()
    }

    func searchBreedInitialLetter(){

        print("Select a letter")
        let letterSelected = Character(readLine()!.uppercased())
        let breedsByInitialSelected = catPresenter.getBreedsByInitialSelected(letterSelected:letterSelected)

        if !(breedsByInitialSelected.isEmpty == false) {
            print("There are no breeds with this initial")
            goBackSystemMainMenuView()
        }else{
            var numberBreeds = 1
            print("selected opcion")
            for breeds in breedsByInitialSelected {
                print("\(numberBreeds). \(breeds.name)")
                numberBreeds += 1
            }
            print("Number")
            descriptionOfBreeds(breedsByInitialSelected)
            
        }
        goBackSystemMainMenuView()
 
    }
    //
    func votesView(){
       

            print("The Cat Breed Battle\n1.Vote\n2.Voted List\n3.Breeds\n4.Back")
            switch readLine()! {
                case "1":
                    votesBreeds()
                case "2":
                    breedsVotingResult()
                case "3":
                    showInitialLettersOfTheBreeds()
                    
                default:
                    goBackSystemMainMenuView()
            }

    }

    func votesBreeds(){

        var exit:Bool = true
        repeat{
            let breedCat = catPresenter.ramdomBreed()
            cleanConsole()
            print("******************** The Cat Breed Battle *******************")
            print("Breed Name: \(breedCat.name)")
            print("Selected Option\n0.Dislike 1.Like 2.Leave")
            switch Int(readLine()!) {
                case 0:
                    catPresenter.addVotes(idImage:breedCat.reference_image_id ?? "" , vote: 0)
                case 1:
                    catPresenter.addVotes(idImage:breedCat.reference_image_id ?? "" , vote: 1)
                default:
                    exit = false   
            }
        }while exit    
        goBackSystemVotesView() 
    }

    func breedsVotingResult(){
        let breeds = catPresenter.getbreeds()
        var votesLike = 0 , votesDislike = 0
        catPresenter.getVotes(onCompletion:{ votes in 
            for breed in breeds {
                for vote in votes {
                    if(vote.image_id == breed.reference_image_id ?? "" ){
                        if(vote.value == 0){
                            votesDislike = votesDislike + 1
                        }else if vote.value == 1{
                            votesLike = votesLike + 1
                        }
                    }  
                }
                print("Breed: \(breed.name)\nLike: \(votesLike) Dislike:\(votesDislike)")
                votesLike = 0 
                votesDislike = 0
                print("***********************************")
            }
            
        })

        goBackSystemVotesView()
        
       
    }

    func descriptionOfBreeds(_ breeds:[Cat]){
        let numberBreed = Int(readLine()!)!
        let breed = breeds[numberBreed-1]
        let totalBreedsFound = breeds.count
        if numberBreed >= 1 && numberBreed < totalBreedsFound{
              print("Breeds Name: \(breed.name) Description: \(breed.description)")
        }else{
            print("does not exist")
        }
        goBackSystemMainMenuView()
    }

    func valuOpcion(opcion:String)-> Bool{
        if(opcion.uppercased() == "Y"){
            return true
        }
        return false
    }

    func goBackSystemVotesView(){
        readLine()
        print("back // Y: yes N: not")
        let opcion = readLine()!
        if (valuOpcion(opcion:opcion)){
             cleanConsole()
             votesView()
         }
    }

    func goBackSystemMainMenuView(){
        readLine()
        print("back // Y: yes N: not")
        let opcion = readLine()!
        if (valuOpcion(opcion:opcion)){
             cleanConsole()
             viewMainMenu()
         }
    }
}