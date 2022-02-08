//
//  VideosVM.swift
//  PetFinder
//
//  Created by hkarkin on 7.02.2022.
//

import Foundation

class VideosVM: ViewModelType {
    
    private let videos: [Video]
    
    init(videos: [Video]) {
        self.videos = videos
    }
}

// MARK: - VM I/O
extension VideosVM {
    struct Input {
    }
    
    struct Output {
        var videos: [Video]
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        output(Output(videos: videos))
    }
}
