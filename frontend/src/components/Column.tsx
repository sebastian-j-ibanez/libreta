import { createResource } from "solid-js";
import { getColumnsMock, type Column } from "../api/data";

export default function Column(props: { column: Column }) {
  return (
    <div class="w-full min-w-100 border-zinc-600 border rounded-lg">
      <div class="text-2xl text-center">{props.column.name}</div>
    </div>
  );
}
