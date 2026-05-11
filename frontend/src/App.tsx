import Sidebar from "./components/Sidebar";
import Board from "./components/Board";

export default function App() {
  return (
    <div class="flex h-screen">
      <Sidebar />
      <Board />
    </div>
  );
}
