class Puzzle extends React.Component{
	constructor(){
		super()
		this.state = {
			board: []
		}
		this.split_board = this.split_board.bind(this),
		this.solve = this.solve.bind(this)
	}

	componentDidMount(){

		new_board = this.split_board(this.props.data)

		this.setState({
			board: new_board
		})
	}

	split_board(board){
		nestedBoard = []
		for (var i = 0; i < 9; i++) {		
			nestedBoard.push(board.splice(0,9)) 
		}
		return nestedBoard
	}

	solve(event){
		event.preventDefault()

		$.ajax({
			url: '/solve/1',
			method: 'GET'
			}).done((response) =>{
			
				this.setState({
			board: this.split_board(response)
		})
			})
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
						<button type="button" className="btn-lg btn-success btn-block" onClick={this.solve}>Solve!</button>
					</div>
				</div>
			 </div>
		)
	}
}