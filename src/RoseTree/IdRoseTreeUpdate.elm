module IdRoseTreeUpdate exposing (..)

-- core
import List

-- selfmade packages
import RoseTree
import IdWrapper
import IdRoseTree
import SvgElement
import IdRoseTreeDisplay

update : (aMsg -> aModel -> (aModel, Cmd aMsg))
  -> IdRoseTree.Model aModel 
  -> IdRoseTreeDisplay.Msg aMsg aModel 
  -> ( IdRoseTree.Model aModel,  Cmd (IdRoseTreeDisplay.Msg aMsg aModel))
update itemUpdateFunc model msg = 
  case msg of
    IdRoseTreeDisplay.Direction id itemMsg ->
      let (res, cmd) = updateHelperRoseTree itemUpdateFunc model id itemMsg
      in (res, Cmd.map (IdRoseTreeDisplay.Direction id) cmd)
    IdRoseTreeDisplay.New id ->
      (model, Cmd.none)
    IdRoseTreeDisplay.CreatedRandom idParent newId ->
      (model, Cmd.none)

updateHelperRoseTree :  (aMsg -> aModel -> (aModel, Cmd aMsg)) 
  -> IdRoseTree.Model aModel 
  -> IdWrapper.Id 
  -> aMsg 
  -> ( IdRoseTree.Model aModel, Cmd aMsg)
updateHelperRoseTree itemUpdateFunc tree id msg = 
  let 
    testFunc = (\testTree -> (IdWrapper.getId (RoseTree.root testTree))==id)
    updateFunc = createUpdateHelperTreeItemWithoutId (\itemModel -> let (res,cmd) = itemUpdateFunc msg itemModel in res ) -- discard command for now :( HELP!!
  in 
    (RoseTree.findAndUpdate testFunc updateFunc tree, Cmd.none)

createUpdateHelperTreeItemWithoutId : (aModel -> aModel) -> (IdRoseTree.Model aModel -> IdRoseTree.Model aModel)
createUpdateHelperTreeItemWithoutId func =
  (\tree ->
    let
      children = RoseTree.children tree
      itemWithId = RoseTree.root tree
      id = IdWrapper.getId itemWithId
      item = IdWrapper.getItem itemWithId
      updatedItem = func item
    in
      (RoseTree.addChildren children (RoseTree.singleton (IdWrapper.Wrapper id updatedItem)))
  )


  
