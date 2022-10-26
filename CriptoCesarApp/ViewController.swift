//
//  ViewController.swift
//  CriptoCesarApp
//
//  Created by Leonardo Portes on 25/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var rootView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        title = "Cripto App"
    }

}

final class HomeView: UIView, ViewCodeContract {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var encodeTextField: EFTextField = {
        let textField = EFTextField(
            titlePlaceholder: "texto para criptografar",
            textColor: .black,
            radius: 5,
            borderColor: UIColor(named: "borderBrown")?.cgColor ?? UIColor.darkGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .alphabet
        )
        
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var numberTextField: EFTextField = {
        let textField = EFTextField(
            textColor: .black,
            radius: 5,
            borderColor: UIColor(named: "borderBrown")?.cgColor ?? UIColor.darkGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .numberPad
        )
        return textField
    }()
    
    
    private lazy var encodeButton: EFButton = {
        let button = EFButton(
            title: "Criptografar",
            colorTitle: .black,
            radius: 10,
            background: UIColor(named: "brownHigh") ?? .systemGreen
            
        )
        button.addTarget(self, action: #selector(didTapEncodeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var resultEncodelabel = UILabel() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Resultado criptografado:"
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .darkGray
    }
    
    private lazy var resultValueEncodelabel = UILabel() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.numberOfLines = .zero
        $0.font = .boldSystemFont(ofSize: 17)
    }

    // MARK: - Decode
    private lazy var decodeTextField: EFTextField = {
        let textField = EFTextField(
            titlePlaceholder: "texto para descriptografar",
            textColor: .black,
            radius: 5,
            borderColor: UIColor(named: "borderBrown")?.cgColor ?? UIColor.darkGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .alphabet
        )
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    private lazy var decodeNumberTextField: EFTextField = {
        let textField = EFTextField(
            textColor: .black,
            radius: 5,
            borderColor: UIColor(named: "borderBrown")?.cgColor ?? UIColor.darkGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .numberPad
        )
        return textField
    }()

    private lazy var decodeButton: EFButton = {
        let button = EFButton(
            title: "Descriptografar",
            colorTitle: .black,
            radius: 10,
            background: UIColor(named: "brownHigh") ?? .systemGreen
        )
        button.addTarget(self, action: #selector(didTapDecodeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var resultDecodelabel = UILabel() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Resultado descriptografado:"
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .darkGray
    }
    
    private lazy var resultValueDecodelabel = UILabel() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.numberOfLines = .zero
        $0.font = .boldSystemFont(ofSize: 17)
    }

    @objc
    func didTapEncodeButton() {
        let result = caesarEncode(encodeTextField.text?.lowercased() ?? "", shiftBy: Int(numberTextField.text ?? "") ?? 0)
        decodeTextField.text = result
        decodeNumberTextField.text = numberTextField.text
        resultValueDecodelabel.text = ""
        
        if encodeTextField.text == "" {
            print("PALAVRA VAZIA")
        }
        
        if numberTextField.text == "" {
            print("nUMERO VAZIA")
        }
        resultValueEncodelabel.text = result.uppercased()
    }

    @objc
    func didTapDecodeButton() {
        let result = caesarDecode(decodeTextField.text?.lowercased() ?? "", shiftBy: Int(decodeNumberTextField.text ?? "") ?? 0)
     
        if decodeTextField.text == "" {
            print("PALAVRA VAZIA")
        }
        
        if decodeNumberTextField.text == "" {
            print("nUMERO VAZIA")
        }
        resultValueDecodelabel.text = result.uppercased()
    }
    
    func setupHierarchy() {
        addSubview(encodeTextField)
        addSubview(numberTextField)
        addSubview(resultEncodelabel)
        addSubview(resultValueEncodelabel)
        addSubview(encodeButton)
        
        addSubview(decodeTextField)
        addSubview(decodeNumberTextField)
        addSubview(resultDecodelabel)
        addSubview(resultValueDecodelabel)
        addSubview(decodeButton)
    }
    
    func setupConstraints() {
        encodeTextField
            .topAnchor(in: self, padding: 100)
            .leftAnchor(in: self, padding: 30)
            .rightAnchor(in: numberTextField, attribute: .left, padding: 16)
            .heightAnchor(40)
        
        numberTextField
            .topAnchor(in: self, padding: 100)
            .rightAnchor(in: self, padding: 30)
            .heightAnchor(40)
            .widthAnchor(50)
        
        resultEncodelabel
            .topAnchor(in: encodeTextField, attribute: .bottom, padding: 10)
            .leftAnchor(in: self, padding: 30)
            .heightAnchor(30)
        
        resultValueEncodelabel
            .topAnchor(in: resultEncodelabel, attribute: .bottom)
            .leftAnchor(in: self, padding: 30)
            .rightAnchor(in: self, padding: 30)
         
        encodeButton
            .topAnchor(in: resultValueEncodelabel, attribute: .bottom, padding: 30)
            .leftAnchor(in: self, padding: 30)
            .rightAnchor(in: self, padding: 30)
            .heightAnchor(45)
            
        decodeTextField
            .topAnchor(in: encodeButton, padding: 100)
            .leftAnchor(in: self, padding: 30)
            .rightAnchor(in: decodeNumberTextField, attribute: .left, padding: 16)
            .heightAnchor(40)
        
        decodeNumberTextField
            .topAnchor(in: encodeButton, padding: 100)
            .rightAnchor(in: self, padding: 30)
            .heightAnchor(40)
            .widthAnchor(50)
        
        resultDecodelabel
            .topAnchor(in: decodeTextField, attribute: .bottom, padding: 10)
            .leftAnchor(in: self, padding: 30)
            .heightAnchor(30)
        
        resultValueDecodelabel
            .topAnchor(in: resultDecodelabel, attribute: .bottom)
            .leftAnchor(in: self, padding: 30)
            .rightAnchor(in: self, padding: 30)
        
        decodeButton
            .topAnchor(in: resultValueDecodelabel, attribute: .bottom, padding: 30)
            .leftAnchor(in: self, padding: 30)
            .rightAnchor(in: self, padding: 30)
            .heightAnchor(45)
    }
    
    func setupConfiguration() {
        backgroundColor = UIColor(named: "brown") ?? .white
    }
    
    let alphabet: [Character] = Array("abcdefghijklmnopqrstuvwxyz")
    
    func caesarEncode(_ input: String, shiftBy: Int = 7) -> String {
        let letterA = Int("a".utf16.first!)
        let letterZ = Int("z".utf16.first!)
        let letterCount = letterZ - letterA + 1

        var result = [UInt16]()
        result.reserveCapacity(input.utf16.count)

        for char in input.utf16 {
            let value = Int(char)
            switch value {
            case letterA...letterZ:
                let offset = value - letterA
                var newOffset = (offset + shiftBy) % letterCount
                if newOffset < 0 { newOffset += letterCount }
                result.append(UInt16(letterA + newOffset))
            default:
                break
            }
        }

        return String(utf16CodeUnits: &result, count: result.count)
    }

    func caesarDecode(_ input: String, shiftBy: Int = 7) -> String {
        return caesarEncode(input, shiftBy: -shiftBy)
    }
}
