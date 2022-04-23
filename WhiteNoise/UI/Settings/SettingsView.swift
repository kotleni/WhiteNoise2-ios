//
//  SettingsView.swift
//  WhiteNoise
//
//  Created by Victor Varenik on 21.04.2022.
//

import UIKit

class SettingsView: UIView {
    private lazy var label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Nunito-Bold", size: 22)
        view.textColor = .fromNormalRgb(red: 241, green: 233, blue: 255)
        view.text = "Settings"
        
        return view
    }()
    
    private lazy var closeBtn: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "CloseButton")
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeView))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var framez: SettingsFrameView = {
        let view = SettingsFrameView(settingsView: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.register(SettingItemCell.self, forCellReuseIdentifier: "ItemCell")
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    let items = [
        "SettingsContactUs", "SettingsInviteFriend", "SettingsPrivacyPolicy",
        "SettingsRateUs", "SettingsSetReminder"
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add views
        addSubview(label)
        addSubview(framez)
        addSubview(tableView)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func viewDidAppear(_ animated: Bool) {
        viewController?.navigationController?.view.addSubview(closeBtn)
        viewController?.navigationController?.navigationBar.barStyle = .black
        viewController?.navigationController?.navigationBar.barTintColor = .fromNormalRgb(red: 11, green: 16, blue: 51)
        viewController?.navigationController?.navigationBar.topItem?.setHidesBackButton(true, animated: false)
        
        framez.viewDidAppear(animated)
        
        // closeBtn
        NSLayoutConstraint.activate([
            closeBtn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -32),
            closeBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            closeBtn.widthAnchor.constraint(equalToConstant: 40),
            closeBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpConstraints() {
        // label
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 19),
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -32),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // framez
        NSLayoutConstraint.activate([
            framez.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            framez.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            framez.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            framez.heightAnchor.constraint(equalToConstant: 240),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: framez.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func closeView(view: UIView) {
        viewController?.navigationController?.popViewController(animated: true)
        closeBtn.removeFromSuperview()
    }
    
    private func itemSelected(pos: Int) {
        closeBtn.removeFromSuperview()
        
        switch pos {
        case 2:
            viewController?.navigationController?
                .pushViewController(PrivacyViewController(), animated: true)
            break
        default:
            break
        }
    }
    
    func subButtonClick() {
        viewController?.navigationController?.pushViewController(PaywallViewController(), animated: true)
        closeBtn.removeFromSuperview()
    }
}

extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell")! as! SettingItemCell
        let item = items[indexPath.row]
        
        cell.updateCell(imageName: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemSelected(pos: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let selectionColor = UIView() as UIView
        selectionColor.backgroundColor = UIColor.fromNormalRgb(red: 22, green: 29, blue: 83)
        cell.selectedBackgroundView = selectionColor
    }
}