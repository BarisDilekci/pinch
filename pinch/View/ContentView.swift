//
//  ContentView.swift
//  pinch
//
//  Created by Barış Dilekçi on 5.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - PROPERTIES
    @State private var isAnimating : Bool = true
    @State private var imageScale : CGFloat = 1
    @State private var imageOffset : CGSize = .zero
    
    
    //MARK: - FUNCTIONS
    func resetImageState() {
      return withAnimation(.spring()) {
        imageScale = 1
        imageOffset = .zero
      }
    }
    
    
    //MARK: - LIFE CYCLE
    var body: some View {
        NavigationView{
            ZStack{
                Color.clear
                //IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                
                //MARK: - TAP GESTURE
                    .onTapGesture {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            withAnimation(.spring()) {
                                imageScale = 1
                            }
                        }
                    }
                //MARK: - DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            })
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    withAnimation(.spring()) {
                                        imageScale = 1
                                        imageOffset = .zero
                                    }
                                }
                            })
                    )
                
            } //: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
            
            //MARK: - INFO PANEL
            .overlay(
              InfoPanelView(scale: imageScale, offset: imageOffset)
                .padding(.horizontal)
                .padding(.top, 30)
              , alignment: .top
            )
            
            .overlay(
                Group {
                  HStack {
                    // SCALE DOWN
                    Button {
                      withAnimation(.spring()) {
                        if imageScale > 1 {
                          imageScale -= 1
                          
                          if imageScale <= 1 {
                            resetImageState()
                          }
                        }
                      }
                    } label: {
                      ControlImageView(icon: "minus.magnifyingglass")
                    }
                    
                    // RESET
                    Button {
                      resetImageState()
                    } label: {
                      ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                    }
                    
                    // SCALE UP
                    Button {
                      withAnimation(.spring()) {
                        if imageScale < 5 {
                          imageScale += 1
                          
                          if imageScale > 5 {
                            imageScale = 5
                          }
                        }
                      }
                    } label: {
                      ControlImageView(icon: "plus.magnifyingglass")
                    }
                    
                  } //: CONTROLS
                  .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                  .background(.ultraThinMaterial)
                  .cornerRadius(12)
                  .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom, 30)
                , alignment: .bottom
            )
        } //: NAVIGATION
        .navigationViewStyle(.stack)

    }
}

#Preview {
    ContentView()
}
