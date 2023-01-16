//
//  LibraryPlaylistViewController.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 14.01.2023.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {
    
    private let noPlaylistView = ActionLabelView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()

    var playlists = [Playlist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        setupNoPlaylistsView()
        fetchPlaylists()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistView.center = view.center
        tableView.frame = view.bounds
    }
    
    private func setupNoPlaylistsView() {
        view.addSubview(noPlaylistView)
        noPlaylistView.delegate = self
        noPlaylistView.configure(with: ActionLabelViewViewModel(
            text: "You don't have any playlists yet",
            actionTitle: "Create"))
    }
    
    private func fetchPlaylists() {
        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self?.playlists = result.items
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            // show label
            noPlaylistView.isHidden = false
            tableView.isHidden = true
        }
        else {
            // show table
            tableView.reloadData()
            tableView.isHidden = false
            noPlaylistView.isHidden = true
        }
    }

    public func showCreatePlaylistAlert() {
        let alert = UIAlertController(title: "New Playlist",
                                      message: "Enter playlist name",
                                      preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Playlist..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let textField = alert.textFields?.first,
                  let text = textField.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                      return
                  }
            
            APICaller.shared.createPlaylist(with: text) { [weak self] success in
                if success {
                    // Refresh list of playlists
                    self?.fetchPlaylists()
                }
                else {
                    print("Failed to create playlist")
                }
            }
        }))
        
        present(alert, animated: true)
    }
}

extension LibraryPlaylistsViewController: ActionLabelViewDelegate {
    
    func actionLabelViewDidTapButton(_ actionLabelView: ActionLabelView) {
        // show create playlist UI
        showCreatePlaylistAlert()
    }
    
    
}

extension LibraryPlaylistsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        
        let playlist = playlists[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(
            title: playlist.name,
            subTitle: playlist.owner.display_name,
            imageURL: URL(string: playlist.images.first?.url ?? "")))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
