//
//  StickyHeadActivity.swift
//  Dono
//
//  Created by Bahtiar on 13/07/26.
//

import SwiftUI

struct ActivityHistory: Identifiable {
    let id = UUID()
    let month: String
}

struct ActivityHistorySheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let histories = [
        ActivityHistory(month: "June 2026"),
        ActivityHistory(month: "May 2026"),
        ActivityHistory(month: "April 2026")
    ]
    
    var body: some View {
        
        VStack(spacing: 18) {
            
            // Header
            ZStack {
                
                Text("Activity History Download")
                    .font(.system(size: 22, weight: .bold))
                
                HStack {
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 22))
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding(.horizontal)
            
            // Info
            HStack(spacing: 12) {
                
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(.gray)
                
                Text("There will be a notification once the request is done.")
                    .font(.system(size: 12))
                
                Spacer()
                
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // Choose Month
            Button {
                
            } label: {
                
                HStack {
                    
                    Text("Choose Month")
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .padding()
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3))
                )
            }
            
            // List
            VStack(spacing: 14) {
                
                ForEach(histories) { history in
                    
                    Button {
                        
                    } label: {
                        
                        HStack {
                            
                            Text(history.month)
                                .font(.system(size: 18))
                            
                            Spacer()
                            
                            Image(systemName: "square.and.arrow.down")
                                .font(.system(size: 24))
                                .foregroundStyle(.blue)
                        }
                        .padding()
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.25))
                        )
                    }
                    .buttonStyle(.plain)
                    
                }
            }
            
            Spacer()
            
        }
        .padding()
        .presentationDetents([.height(560)])
        .presentationDragIndicator(.hidden)
    }
}

struct StickyHeadActivity: View {
    @Environment(\.dismiss) private var dismiss
    @State private var buttonDownload = false
    
    var body: some View {
        ZStack {
            Text("Activity")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
                
                Spacer()
                Button {
                    buttonDownload = true
                } label: {
                    Image(systemName: "square.and.arrow.down")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom)
        .frame(maxWidth: .infinity)
        .background(.blue)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $buttonDownload) {
            ActivityHistorySheet()
                .presentationDetents([.height(560)])
                .presentationCornerRadius(22)
                .presentationBackground(.background)
        }
    }
}

#Preview {
    StickyHeadActivity()
}
