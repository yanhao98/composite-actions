while gh run list --json databaseId --jq '.[].databaseId' | grep -q .; do
  for id in $(gh run list --json databaseId --jq '.[].databaseId'); do gh run delete $id; done
  echo "继续删除下一批..."
done
