module IdRoseTreeUpdate exposing (..)

-- core
import List

-- selfmade packages
import RoseTree
import IdWrapper
import IdRoseTree
import SvgElement
import IdRoseTreeDisplay

update : (SvgElement.Msg -> SvgElement.Model -> (SvgElement.Model, Cmd SvgElement.Msg))
  -> IdRoseTree.Model SvgElement.Model 
  -> IdRoseTreeDisplay.Msg SvgElement.Msg SvgElement.Model 
  -> ( IdRoseTree.Model SvgElement.Model
     ,  Cmd (IdRoseTreeDisplay.Msg SvgElement.Msg SvgElement.Model)
     )
update itemUpdateFunc model msg = 
  case msg of
    IdRoseTreeDisplay.Direction id itemMsg ->
      --(model, Cmd.none)
      let (res, cmd) = updateHelperRoseTree itemUpdateFunc model id itemMsg
      in (res, Cmd.map (IdRoseTreeDisplay.Direction id) cmd)
    IdRoseTreeDisplay.New id ->
      (model, Cmd.none)
    IdRoseTreeDisplay.CreatedRandom idParent newId ->
      (model, Cmd.none)

updateHelperRoseTree :  (SvgElement.Msg -> SvgElement.Model -> (SvgElement.Model, Cmd SvgElement.Msg)) 
  -> IdRoseTree.Model SvgElement.Model 
  -> IdWrapper.Id -> SvgElement.Msg 
  -> ( IdRoseTree.Model SvgElement.Model, Cmd SvgElement.Msg)
updateHelperRoseTree itemUpdateFunc tree id msg = 
  let 
    testFunc = (\testTree -> (IdWrapper.getId (RoseTree.root testTree))==id)
    updateFunc = createUpdateHelperTreeItemWithoutId (\svgElementModel -> let (res,cmd) = itemUpdateFunc msg svgElementModel in res ) -- discard command for now :( HELP!!
  in 
    (RoseTree.findAndUpdate testFunc updateFunc tree, Cmd.none)

--createUpdateHelperTreeItemWithoutId : (SvgElement.Model-> SvgElement.Model) -> (IdRoseTree.Model SvgElement.Model -> IdRoseTree.Model SvgElement.Model)
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


  
