import Nat32 "mo:base/Nat32";
import Trie "mo:base/Trie";
import Option "mo:base/Option";
import List "mo:base/List";
import Text "mo:base/Text";
import Result "mo:base/Result";

actor SuperHeroes {

  public type SuperHero = {
    name : Text;
    superpowers: List.List<Text>;
  };


  public type SuperHeroId = Nat32;

  private stable var next : SuperHeroId = 0;

  private stable var superheroes : Trie.Trie<SuperHeroId ,SuperHero> = Trie.empty();

  public func createHero (newHero: SuperHero) : async Nat32 {
    let id = next;
    next += 1;

    superheroes := Trie.replace(
      superheroes, 
      key(id), 
      Nat32.equal,
      ?newHero
    ).0;
    
    return id;
  };

  public func getHero (id: SuperHeroId) : async ?SuperHero {
    let Result = Trie.find(
      superheroes,
      key(id),
      Nat32.equal
    );

    return Result;
  };

  public func updateHero(id : SuperHeroId, newHero: SuperHero) : async Nat32 {
    let Result = Trie.find(
      superheroes,
      key(id),
      Nat32.equal
    );

    let exists = Option.isSome(Result);

    if(exists) {
      superheroes := Trie.replace(superheroes, key(id), Nat32.equal, ?newHero).0;
    };
  };

  private func key (x: SuperHeroId): Trie.Key<SuperHeroId> {
    {hash = x ; key = x};
  };
};
