import './assets/App.css'
import Sidebar from './components/Sidebar'
import Board from './components/Board'

export default function App() {

    return (
        <div>
            <Sidebar />
            <div class="ml-60 p-4">
                <Board />
            </div>
        </div>
    )
}
