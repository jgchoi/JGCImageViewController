/*
 
 MIT License
 
 Copyright (c) 2017 Jung Geon Choi
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */
import UIKit

extension UIViewController {
    func present(image: UIImage) {
        let vc = JGCImageViewController()
        vc.view.frame = view.frame
        vc.image = image
        present(vc, animated: true, completion: nil)
    }
    
    func present(_ image: UIImage, from initialView: UIView) {
        let vc = JGCImageViewController()
        let imageView = UIImageView(frame: initialView.frame)
        let backgroundView = UIView(frame: view.frame)
        
        vc.view.frame = view.frame
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        
        imageView.image = image
        imageView.layer.cornerRadius = initialView.layer.cornerRadius
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(backgroundView)
        view.addSubview(imageView)
        
        vc.initialViewCornerRadius = initialView.layer.cornerRadius
        vc.initialViewFrame = initialView.layer.frame
        vc.image = image
        
        UIView.animate(withDuration: 0.2, animations: {
            backgroundView.alpha = 1.0
            imageView.frame = self.view.frame
            imageView.layer.cornerRadius = 0
        }) { _ in
            self.present(vc, animated: false, completion: {
                imageView.removeFromSuperview()
                backgroundView.removeFromSuperview()
            })
            
        }
        
    }
}

class JGCImageViewController: UIViewController {
    var image: UIImage! {
        didSet {
            setScrollView()
        }
    }
    var imageView: UIImageView!
    var isButtonVisiable = false
    var closeButton = UIButton(frame: CGRect(x: 16, y: 32, width: 50, height: 44))
    var initialViewCornerRadius: CGFloat?
    var initialViewFrame: CGRect?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureRecognizer()
    }
    
    func addCloseButton() {
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.setTitleColor(.lightGray, for: .highlighted)
        closeButton.alpha = 0.0
        closeButton.addTarget(self, action: #selector(didTabCloseButton), for: .touchUpInside)
        view.addSubview(closeButton)
        
    }
    
    @objc func didTabCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func setScrollView() {
        let scrollView = UIScrollView()
        scrollView.frame = view.frame
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.flashScrollIndicators()
        scrollView.backgroundColor = .black
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.delegate = self
        
        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = view.frame
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        addCloseButton()
    }
    
    func addTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(sender:)))

        view.addGestureRecognizer(tap)
    }
    
    func toggleButton() {
        let targetAlpha: CGFloat = isButtonVisiable ? 0.0 : 1.0
        isButtonVisiable = !isButtonVisiable
        UIView.animate(withDuration: 0.3) {
            self.closeButton.alpha = targetAlpha
        }
    }
    
    @objc func tapHandler(sender: UIGestureRecognizer) {
        toggleButton()
    }
}

extension JGCImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
