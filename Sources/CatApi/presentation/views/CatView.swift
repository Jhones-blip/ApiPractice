import Foundation

class CatView{
    static let instance:CatView = CatView()
    //let votedCat:CatViewVoted = CatViewVoted()
    let catPresenter:CatPresenter = CatPresenter.instance
    
    let votePresenter:vote = vote(breed: "", like: "", disLike: "")

    func start(){
        catPresenter.loadBreeds()
        viewMainMenu()
    }

    func viewMainMenu(){
        print("Welcome to TheApiCat\n1.Initial letters of Breeds\n2.Breeds Library\n3.The Cat Breed Battle\n4.Exit")

        switch readLine()! {
        case "1":
                InitialLettersOfTheBreeds()
                viewSearchBreed()
                goBackSystemMainMenuView()
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
        let cats = catPresenter.getbreeds()
        for cat  in cats {
            print("\(cat.name) -> origin: \(cat.origin)" )  
        }
    }

    func InitialLettersOfTheBreeds(){
        let letters = catPresenter.getinitialLetterBreeds()
        for letter  in letters {
            print(letter)
        }
    }

    func viewSearchBreed(){

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
    //
    func votesView(){
        cleanConsole()
        print("The Cat Breed Battle\n1.Vote\n2.Voted List\n3.Breeds\n4.Back")

        switch readLine()! {
        case "1":
            votesBreeds()
        case "2":
            votingResult()
        case "3":
            InitialLettersOfTheBreeds()
            viewSearchBreed()
        default:
            goBackSystemMainMenuView()
        }
    }

    var savedVotes: [vote] = []

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
                    let trackingVote = vote(breed: breedCat.name, like: "0", disLike: "1")
                    self.savedVotes.append(trackingVote)
                    //catPresenter.addVotes(idImage:breedCat.reference_image_id ?? "" , vote: 0)
                case 1:
                    let trackingVote = vote(breed: breedCat.name, like: "1", disLike: "0")
                    self.savedVotes.append(trackingVote)
                    //catPresenter.addVotes(idImage:breedCat.reference_image_id ?? "" , vote: 1)
                default:
                    goBackSystemVotesView()
                    exit = false   
            }
        }while exit    
         
    }

    func votingResult(){
        for voteResult in savedVotes{
            print("Breed -> ",voteResult.breed,"Likes -> ",voteResult.like,"Dislike -> ",voteResult.disLike)
            
        }
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
        print("Go back?\nY: yes\nN: not")
        let opcion = readLine()!
        if (valuOpcion(opcion:opcion)){
             cleanConsole()
             votesView()
         }
    }

    func goBackSystemMainMenuView(){
        readLine()
        print("Go back?\nY: yes\nN: not")
        let opcion = readLine()!
        if (valuOpcion(opcion:opcion)){
             cleanConsole()
             viewMainMenu()
         }
    }

}