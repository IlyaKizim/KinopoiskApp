import UIKit
import WebKit

class PresentPlayViewController: UIViewController {

    private lazy var buttonBack: UIButton = {
        let buttonBack = UIButton()
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.backgroundColor = .white
        buttonBack.setTitle("Back", for: .normal)
        buttonBack.setTitleColor(.black, for: .normal)
        buttonBack.layer.cornerRadius = 10
        buttonBack.addTarget(self, action: #selector(dismissed), for: .touchUpInside)
        return buttonBack
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        addSubviews()
        setConstraints()
    }
    
    @objc func dismissed () {
        dismiss(animated: true, completion: nil)
    }
    
    func configure(with model: String) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(model)") else {
            return}
        webView.load(URLRequest(url: url))
    }
    
    private func addSubviews() {
        view.addSubview(buttonBack)
        view.backgroundColor = .black
        view.addSubview(webView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250)
        ])
        NSLayoutConstraint.activate([
            buttonBack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonBack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonBack.widthAnchor.constraint(equalToConstant: 100),
            buttonBack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


