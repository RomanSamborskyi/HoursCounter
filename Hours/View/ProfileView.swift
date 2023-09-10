//
//  ProfileView.swift
//  Hours
//
//  Created by Roman Samborskyi on 16.08.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @AppStorage("salaryPerHour") var salaryPerHour: Int = 0
    @AppStorage("userName") var userName: String = ""
    @State private var hourSalaryTextFieald: String = ""
    @State private var userNameTextField: String = ""
    @AppStorage("editUserName") var editUserName: Bool = false
    var body: some View {
        NavigationView {
            List {
                Section("User name") {
                    if  !editUserName {
                        HStack {
                            TextField("Enter name", text: $userNameTextField)
                                .padding()
                                .frame(width: 240,height: 30)
                            Button(action: {
                                withAnimation(Animation.spring()) {
                                    self.userName = userNameTextField
                                    self.editUserName = true
                                }
                            }, label: {
                                Text("Save")
                                    .padding(5)
                                    .foregroundColor(.blue)
                                    .frame(width: 90,height: 30)
                            })
                        }
                    } else {
                        HStack {
                            Image(systemName: "person.circle")
                                .font(.title3)
                            Text(userName)
                                .font(.title2)
                            Spacer()
                            Button(action: {
                                self.editUserName = false
                            }, label: {
                                Text("Edit")
                                    .padding(5)
                                    .foregroundColor(.blue)
                                    .frame(width: 75,height: 30)
                            })
                        }
                    }
                }
                Section("Hour salary") {
                if salaryPerHour == 0 {
                    HStack {
                        TextField("Enter value", text: $hourSalaryTextFieald)
                            .padding()
                            .frame(width: 240,height: 30)
                            .keyboardType(.numberPad)
                        Button(action: {
                            withAnimation(Animation.spring()) {
                                self.salaryPerHour = Int(hourSalaryTextFieald) ?? 0
                            }
                        }, label: {
                            Text("Save")
                                .padding(5)
                                .foregroundColor(.blue)
                                .frame(width: 90,height: 30)
                        })
                    }
                } else {
                    HStack {
                        Text(" \(salaryPerHour)")
                        Spacer()
                        Button(action: {
                            self.salaryPerHour = 0
                        }, label: {
                            Text("Edit")
                                .padding(5)
                                .foregroundColor(.blue)
                                .frame(width: 75,height: 30)
                        })
                    }
                }
             }
            }.navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
