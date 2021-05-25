//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

protocol drawable {
    func draw()
    //func sketch()
}
extension drawable {
    func draw() {
        print("drawing")
        sketch()
    }
    func sketch() {
        print("sketching")
    }
}

struct Shape: drawable {
    func sketch() {
        print("custom sketch method")
    }
}

let shape: Shape = Shape()
shape.draw() // "drawing",  custom sketch method
shape.sketch() /// custom sketch method
/*



//dispatch (gcd) & operation ( wrapped GCD)


// Watsapp

-> Listing of contact
-> sending and receiving msg ( text & media)

ListingVC -> ListingVM -> ListDataProvidable ( fetching the list and sending back the list)


ListDataProvidable
    --> networkListDataProvidable - sync contact {
        - send all cantact in local to server -> json with information
        [1234
        135
        123]

        -- sort -> last time

        1234-{
            name :
            prfile image
        }
        - mapping the data from server with local contact
    }
--> PersistanceStarageProvidable

    - load Next list( lastpage) -> list

    - fetchContactlist ( completion: { (list)}) {

        // obj of PersistanceStarageProvidable . fetch data from resouce ( SQLITE/Core)
    }
}

ListViewModel {



    fetchContactlist (completion: { [list ]}) {
    ListDataProvidable. fetchContactlist ( list )
    }
}

Rxobserver {

}

viewccontroller {
    viewModel.fetchContactlist { list

    }

    tablor {
        viewmodel.image for id {
            // check the cache --> placeholder -> start downloading
        }
    }


    Model {
        image :
        name : mapped from local name
        last message :
        status: typing // lastseen

    }

- POLLING -> HTTP ( 5 second)

    rabbitMQ , redis ,

    Observable ( PUB SUB) -> MQTT ( obsersev a topic) -> someone comes online {
        { json {
            123213: online

        }}
    }
*/
DispatchQueue.main.sync {
    for i in 1...1000 {
        print("---", i)
    }
}
DispatchQueue.global().sync {
    for i in 1...1000 {
        print("---", i)
    }
}

DispatchQueue.main.async {
    for i in 1...1000 {
        print("---", i)
    }
}
