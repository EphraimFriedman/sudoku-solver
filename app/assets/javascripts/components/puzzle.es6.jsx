class Puzzle extends React.Component{
	constructor(){
		super()
		this.state = {
			id: "",
			board: [],
			displayPuzzleButton: false,
		}
		this.split_board = this.split_board.bind(this),
		this.solve = this.solve.bind(this),
		this.newPuzzle = this.newPuzzle.bind(this),
		this.buttonDisplay = this.buttonDisplay.bind(this)
	}

	componentDidMount(){

		new_board = this.split_board(this.props.data.board)

		this.setState({
			id: this.props.data.id,
			board: new_board

		})
	}

	split_board(board){

		first_split = board.split('')

		nestedBoard = []
		for (var i = 0; i < 9; i++) {
			nestedBoard.push(first_split.splice(0,9))
		}
		return nestedBoard
	}

	solve(event){
		event.preventDefault()

		id = this.props.data.id

		this.setState({
			id: id
		})

		$.ajax({
			url: "/solve/" + this.state.id,
			method: 'GET'
			}).done((response) =>{

				this.setState({
			board: this.split_board(response),
			displayPuzzleButton: true
		})
			})
	}

	newPuzzle(event){
		event.preventDefault()

		$.ajax({
			url: "/puzzles",
			method: 'GET'
			}).done((response) =>{

			this.setState({
				id: response.id,
				board: this.split_board(response.board),
				displayPuzzleButton: false
			})

			})
	}

	toggleNewPuzzleButton(){

	}

	buttonDisplay(){
		if(this.state.displayPuzzleButton){
			return(<button type="button" className="btn-lg btn-success btn-block" onClick={this.newPuzzle}>New Puzzle!</button>)
		}else{
			return(<button type="button" className="btn-lg btn-success btn-block" onClick={this.solve}>Solve!</button>)
		}
	}

	render(){
		return(
			<div className="container">
				<div className="row">
					<div className="col-md-4 col-md-offset-4">




			 			<table className="table table-bordered text-center">
							<tbody>

					 			{
					 				this.state.board.map((row, idx) => {
						 				return (
						 					<tr>
						 						{ row.map((num) => {
						 							if(num === '-'){
						 								return (<td></td>)
						 							}else{
						 							return (<td>{num}</td>)}
						 						}
						 						)}
						 					</tr>)
						 				}
					 				)
					 			}

			 				</tbody>
						</table>
					</div>
				</div>
				<div className="row">
					<div className="col-md-4 col-md-offset-4">
					{this.buttonDisplay()}

					</div>
				</div>
			 </div>
		)
	}
}
