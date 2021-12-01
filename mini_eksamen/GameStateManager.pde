public static class GameStateManager  //<>// //<>// //<>// //<>// //<>//

{
  GameState currentGameState;
  HashMap<String, GameState> gameStates;  

  GameStateManager() {
    currentGameState = null;
    gameStates = new HashMap<String, GameState>();
  }

  void Update()
  {
    if (currentGameState != null)
      currentGameState.Update();
  }

  public void AddGameState(String name, GameState state)
  {
    gameStates.put(name, state);   // gamestat tilføjes via string som Key, hvor state er værdien
  }

  public void SkiftGameState(String name) {
    if (currentGameState != null)
      currentGameState.Reset();
    if (gameStates.containsKey(name))
    {
      currentGameState = gameStates.get(name);      
    }
  }

  public void SkiftGameStateQuestion(String name, String[][][] set) {
    if (currentGameState != null)
      currentGameState.Reset();
    if (gameStates.containsKey(name))
    {
      currentGameState = gameStates.get(name);
      currentGameState.InjectSet(set);
    }
  }

  public void Reset()
  {
    if (currentGameState != null)
      currentGameState.Reset();
  }

  public GameState GetGameState(String name)
  {
    if (gameStates.containsKey(name))
      return gameStates.get(name);
    return null;
  }

  public String GetCurrentGameStateName() {
    java.util.Set<String> kSet = gameStates.keySet();
    for (String x : kSet) {
      if ( GetGameState(x) == currentGameState ) {
        return x;
      }
    }
    return "";
  }
}
