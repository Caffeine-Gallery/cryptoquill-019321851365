import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

import Time "mo:base/Time";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Buffer "mo:base/Buffer";

actor {
    // Post type definition
    public type Post = {
        id: Nat;
        title: Text;
        body: Text;
        author: Text;
        timestamp: Int;
    };

    stable var posts : [Post] = [];
    stable var nextId : Nat = 0;

    // Create a new post
    public shared func createPost(title: Text, body: Text, author: Text) : async Post {
        let post : Post = {
            id = nextId;
            title = title;
            body = body;
            author = author;
            timestamp = Time.now();
        };
        
        nextId += 1;
        
        // Create a new array with the new post at the beginning
        posts := Array.tabulate<Post>(posts.size() + 1, func(i) {
            if (i == 0) { post }
            else { posts[i-1] }
        });
        
        post
    };

    // Get all posts in reverse chronological order
    public query func getPosts() : async [Post] {
        posts
    };
}
