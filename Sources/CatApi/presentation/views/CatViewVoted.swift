import Foundation

class CatViewVoted {
    static let instance:CatViewVoted = CatViewVoted()
    let catPresenter:CatPresenter = CatPresenter.instance
    

    func votesView(){
       
        cleanConsole()
        print("------The Cat Breed Battle------\n1.Vote\n2.Voted List\n3.Breeds\n4.Back")
        switch readLine()! {
        case "1":
            votesBreeds()
        case "2":
            breedsVotingResult()
        case "3":
            showInitialLettersOfTheBreeds()
            print("x")
            
        default:
            goBackSystemMainMenuView()
            print("x")
        }

    }

    func cleanConsole(){
        print("\u{1B}[1;1H", "\u{1B}[2J")
    }

    func votesBreeds(){

        var exit:Bool = true
        repeat{
            let breedCat = catPresenter.ramdomBreed()
            cleanConsole()
            print("------ The Cat Breed Battle ------")
            print("Breed Name: \(breedCat.name)")
            print("Selected vote option Option\n0.Dislike \n1.Like \n2.Leave")
            switch Int(readLine()!) {
                case 0:
                    catPresenter.addVotes(idImage:breedCat.reference_image_id ?? "" , vote: 0)
                case 1:
                    catPresenter.addVotes(idImage:breedCat.reference_image_id ?? "" , vote: 1)
                default:
                    goBackSystemVotesView()
                    exit = false   
            }
        }while exit    
         
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
                print("----------------")
            }
            
        })

        goBackSystemVotesView()
        
       
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
            print("")
            for breeds in breedsByInitialSelected {
                print("\(numberBreeds). \(breeds.name)")
                numberBreeds += 1
            }
            print("Select a number for the breed description")
            descriptionOfBreeds(breedsByInitialSelected)
            
        }
        goBackSystemMainMenuView()
 
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

    func goBackSystemMainMenuView(){
        readLine()
        print("back // Y: yes N: not")
        let opcion = readLine()!
        if (valuOpcion(opcion:opcion)){
             cleanConsole()
             //viewMainMenu()
         }
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
}