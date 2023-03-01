//
//  Loader.swift
//  WantedPreOnBoarding_iOS
//
//  Created by WooKoo on 2023/02/22.
//

import Foundation

protocol dataTaskDelegate: AnyObject {
  func sendData(data: Data)
}
protocol DownloaderProtocol: AnyObject {
  func loadImageData()
}

final class Downloader: NSObject, DownloaderProtocol {

  private let urlString = "https://picsum.photos/id/11/240/240"
  weak var delegate: dataTaskDelegate?

  func loadImageData() {
    guard let url = URL(string: urlString) else { return }

    let request = URLRequest(url: url)
    let task = URLSession.shared.downloadTask(with: request)

    task.delegate = self
    task.resume()
  }
}

extension Downloader: URLSessionDownloadDelegate {
  public func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL
  ) {
    if let data = try? Data(contentsOf: location) {
      delegate?.sendData(data: data)
    }
  }

  public func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didWriteData bytesWritten: Int64,
    totalBytesWritten: Int64,
    totalBytesExpectedToWrite: Int64
  ) {
    let percentage = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
    print(percentage)
  }
}
