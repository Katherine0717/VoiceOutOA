//
//  ContentView.swift
//  VoiceOutOA
//
//  Created by Katherine Xiong on 6/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var emailError = true
    @State private var passwordError = true
    @State private var confirmPasswordError = true
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var navigate = false

    var isDisabled: Bool {
        email.isEmpty || password.isEmpty || confirmPassword.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("注册")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Group{
                    VStack(alignment: .leading) {
                        Text("邮箱")
                            .font(.headline)
                            .padding([.top, .leading])
                        TextField("请输入您的邮箱", text: $email)
                            .padding()
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                    }
                    HStack {
                        Text("请输入正确的邮箱格式")
                            .foregroundColor(.red)
                            .font(.caption)
                            .opacity(emailError ? 0 : 1)
                        Spacer()
                            .frame(width: 150.0)
                    }
                }
                
                Group {
                    VStack(alignment: .leading) {
                        Text("密码")
                            .font(.headline)
                            .padding([.top, .leading])
                        ZStack(alignment: .trailing) {
                            if isPasswordVisible {
                                TextField("请输入您的密码", text: $password)
                                    .autocapitalization(.none)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                            } else {
                                SecureField("请输入您的密码", text: $password)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: self.isPasswordVisible ? "eye" : "eye.slash")
                                    .accentColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                    
                    HStack {
                        Text("密码必须不少于8位，包含字母和数字！")
                            .foregroundColor(.red)
                            .font(.caption)
                            .opacity(passwordError ? 0 : 1)
                        Spacer()
                            .frame(width: 60.0)
                    }
                }
                
                Group {
                    VStack(alignment: .leading) {
                        Text("确认密码")
                            .font(.headline)
                            .padding([.top, .leading])
                        ZStack(alignment: .trailing) {
                            if isConfirmPasswordVisible {
                                TextField("确认密码", text: $confirmPassword)
                                    .autocapitalization(.none)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                            } else {
                                SecureField("确认密码", text: $confirmPassword)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                isConfirmPasswordVisible.toggle()
                            }) {
                                Image(systemName: self.isConfirmPasswordVisible ? "eye" : "eye.slash")
                                    .accentColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                    HStack {
                        Text("您输入的密码不一致！")
                            .foregroundColor(.red)
                            .font(.caption)
                            .opacity(confirmPasswordError ? 0 : 1)
                        Spacer()
                            .frame(width: 150.0)
                    }
                }
            }
            Spacer()
                .frame(height: 200.0)
            VStack {
                Button("注册") {
                    if submitRegistration() {
                        print("yes")
                        self.navigate = true
                    } else {
                        print("No")
                    }
                }
                .disabled(isDisabled)
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(isDisabled ? Color.gray : Color.orange)
                .cornerRadius(30)
                .padding(.bottom, 20)
            }
        }.navigationDestination(isPresented: $navigate) {
            RegisterSucceed()
       }.navigationBarHidden(true)
    }

    private func submitRegistration() -> Bool {
        emailError = validateEmail() ? true : false
        passwordError = validatePassword() ? true : false
        confirmPasswordError = validateConfirmPassword() ? true : false

        return emailError && passwordError && confirmPasswordError ? true : false
    }

    private func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func validatePassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

    private func validateConfirmPassword() -> Bool {
        return password == confirmPassword ? true : false
    }
}

#Preview {
    ContentView()
}
