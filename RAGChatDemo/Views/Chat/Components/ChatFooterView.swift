//
//  ChatFooterView.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/4.
//

import SwiftHelpers
import SwiftUI

struct ChatFooterView: View {
    
    // Environment
    @Environment(\.modelContext) private var modelContext
    
    // ViewModel
    @State private var vm = ChatFooterViewViewModel()
    
    // View Properties
    @State private var inputMessage: String = ""
    @State private var isChooseFile: Bool = false
    @State private var showImportFileError: Bool = false
    @State private var importingErrorMessage: String = ""
    @State private var pdfFileURL: URL? = nil
    @Binding var selectedIndex: Int
    
    var body: some View {
        VStack {
            buildInputView()
        }
    }
}

#Preview {
    ChatFooterView(selectedIndex: .constant(0))
}

// MARK: - @ViewBuilder

fileprivate extension ChatFooterView {
    
    @ViewBuilder
    func buildInputView() -> some View {
        HStack {
            switch AppDefine.ChatInputMethod.allCases[selectedIndex] {
            case .text:
                buildKeyboardInput()
            case .voice:
                buildVoiceInput()
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                    .controlSize(.large)
            }
        }
    }
    
    @ViewBuilder
    func buildKeyboardInput() -> some View {
        TextField("Send a message...", text: $inputMessage)
            .textFieldStyle(.roundedBorder)
        buildChooseFileBtn()
        buildSendChatBtn()
    }
    
    @ViewBuilder
    func buildVoiceInput() -> some View {
        Button {
            
        } label: {
            Image(symbols: .musicMic)
        }
        buildChooseFileBtn()
        buildSendChatBtn()
    }
    
    @ViewBuilder
    func buildChooseFileBtn() -> some View {
        Button {
            // 選擇 PDF 檔案
            isChooseFile.toggle()
        } label: {
            Image(symbols: .link)
        }
        .fileImporter(isPresented: $isChooseFile, allowedContentTypes: [.pdf]) { result in
            switch result {
            case .success(let fileURL):
                print(fileURL)
                pdfFileURL = fileURL
            case .failure(let error):
                importingErrorMessage = error.localizedDescription
                showImportFileError.toggle()
            }
        }
        .alert("Importing Error", isPresented: $showImportFileError) {
            Button {
                showImportFileError = false
                isChooseFile = false
            } label: {
                Text("Close")
            }
        } message: {
            Text("Can't import file from Document.\nError: \(importingErrorMessage)")
        }
    }
    
    @ViewBuilder
    func buildSendChatBtn() -> some View {
        Button {
            // 發送訊息
            Task {
                let question = Chat(content: inputMessage, isReply: true)
                try vm.saveChat(context: modelContext, chat: question)
                inputMessage = ""
                
                let res = try await vm.send(question: question.content)
                
                let reply = Chat(content: "Reply:\n\(res.answer)", isReply: false)
                try vm.saveChat(context: modelContext, chat: reply)
            }
        } label: {
            Image(symbols: .paperplane)
        }
    }
}
