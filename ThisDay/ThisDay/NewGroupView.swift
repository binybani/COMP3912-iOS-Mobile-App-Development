//
//  NewGroupViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-07-22.
//
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct NewGroupView: View {
    @State private var groupName = ""
    @State private var groupDescription = ""
    @State private var peopleLimit = 3
    @State private var onlyFriendsPressed = false
    @State private var everyPeoplePressed = false
    @State private var selectedFriends: Set<String> = [] // Store user names

     // Test data
     let friendsData = [
         ("Beanie", UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)),
         ("Anne", UIColor(red: 243/255, green: 179/255, blue: 145/255, alpha: 1.0)),
         ("Ella", UIColor(red: 193/255, green: 223/255, blue: 240/255, alpha: 1.0)),
         ("Julie", UIColor(red: 229/255, green: 198/255, blue: 135/255, alpha: 1.0)),
         ("Jessie", UIColor(red: 255/255, green: 208/255, blue: 123/255, alpha: 1.0)),
         ("Som", UIColor(red: 184/255, green: 242/255, blue: 230/255, alpha: 1.0))
     ]

    
    var databaseRef: DatabaseReference = Database.database().reference()
    
    var body: some View {
        NavigationView { // NavigationView로 뷰를 감싸기
            VStack {
                TextField("Group Name", text: $groupName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Group Description", text: $groupDescription)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Stepper(value: $peopleLimit, in: 1...20, step: 1) {
                    Text("People Limit: \(peopleLimit)")
                        .padding()
                }
                .padding(.top, 20)

                HStack {
                    Button(action: {
                        onlyFriendsPressed.toggle()
                            if onlyFriendsPressed {
                                everyPeoplePressed = false
                            }
                        }) {
                            Text("Only Friedns Allow")
                                .frame(width: 130) // 버튼의 너비를 조절
                        }
                        .buttonStyle(CustomButtonStyle(isPressed: onlyFriendsPressed))
                        
                        Button(action: {
                            everyPeoplePressed.toggle()
                            if everyPeoplePressed {
                                onlyFriendsPressed = false
                            }
                        }) {
                            Text("Welcome Every People")
                                .frame(width: 130) // 버튼의 너비를 조절

                        }
                        .buttonStyle(CustomButtonStyle(isPressed: everyPeoplePressed))
                    }
                    .padding()
                
                Text("Select Friends")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                List {
                     ForEach(friendsData, id: \.0) { friend in
                         HStack {
                             Text(friend.0)
                                 .foregroundColor(.gray)
                                 .padding()
                             Spacer()
                             Image(systemName: selectedFriends.contains(friend.0) ? "checkmark.square.fill" : "square")
                                 .foregroundColor(.gray)
                                 .onTapGesture {
                                     toggleFriendSelection(friend.0)
                                 }
                                 .padding()
                         }
                         .background(Color(friend.1).cornerRadius(10))
                     }
                }
                .background(Color.white)

                Button("Create Group") {
                    createGroup()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color("BtnBackground"))
                .cornerRadius(10)
                .font(.headline.bold())
             }
            .padding()
            .navigationBarTitle("Add New Group", displayMode: .inline)
        }
    }
    
    func toggleFriendSelection(_ friend: String) {
         if selectedFriends.contains(friend) {
             selectedFriends.remove(friend)
         } else {
             selectedFriends.insert(friend)
         }
     }

    func createGroup() {
        guard !groupName.isEmpty, !groupDescription.isEmpty else {
            return
        }
        
        if let user = Auth.auth().currentUser {
            let userId = user.uid
            let groupRef = databaseRef.child("groups").childByAutoId()
            let eventInfo: [String: String] = [
                 "eventName": "",
                 "startDate": "",
                 "endDate": "",
                 "pickedDate": "",
                 "eventNote": ""
             ]
            let groupData: [String: Any] = [
                "name": groupName,
                "description": groupDescription,
                "members": [userId: true],
                "peopleLimit": peopleLimit,
                "isOnlyFriendsAllow": onlyFriendsPressed,
                "event": eventInfo
            ]
            
            groupRef.setValue(groupData) { error, _ in
                if let error = error {
                    print("Error creating group: \(error)")
                } else {
                    print("Group created successfully!")
                    // Send notification
                    NotificationCenter.default.post(name: .newGroupCreated, object: nil)
                    // Move to My group screen
                    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isPressed ? Color.blue : Color.gray)
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isPressed ? Color.blue : Color.gray, lineWidth: 1)
            )
    }
}

struct NewGroupView_Previews: PreviewProvider {
    static var previews: some View {
        NewGroupView()
    }
}

extension Notification.Name {
    static let newGroupCreated = Notification.Name("NewGroupCreated")
}
